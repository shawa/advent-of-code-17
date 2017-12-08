#!/usr/bin/env python3
from operator import itemgetter, add
import sys

import matplotlib.pyplot as plt
import pylab

import time

import networkx as nx

def assign(tup, index, value, f=lambda x, y: x):
    if not (0 <= index < len(tup)):
        raise IndexError("tuple index out of range")
    return tup[:index] + (f(value, tup[index]),) + tup[index+1:]


def run_redistribute_cycle(mem, delay):
    (index, blocks), *rest = sorted(enumerate(mem), key=itemgetter(1), reverse=True)

    mem = assign(mem, index, 0)

    for _ in range(blocks):
        index = (index + 1) % len(mem)
        mem = assign(mem, index, 1, add)
        time.sleep(delay)
        print_mem(mem)
    return mem


def print_mem(mem):
    for x in mem:
        print(f'{x:^ 3}', end=' ')

    print('\r', end='')

def run_reallocator(mem):
    delay = 0.1
    states = nx.DiGraph()

    cur = mem
    states.add_node(cur)

    while states.out_degree(cur) == 0:
        reallocated = run_redistribute_cycle(cur, delay)
        states.add_edge(cur, reallocated)
        cur = reallocated

        print_mem(cur)
        delay *= 0.90

    print(' ' * len(mem) * 4, end='\r')

    return states


def get_reallocation_graph(filename):
    with open(filename, 'r') as f:
        memory = tuple(int(x) for x in f.read().split())

    states = run_reallocator(memory)
    return states


def print_solution(graph):
    n_reallocation_cycles = len(graph.edges)
    n_state_cycles = len(nx.find_cycle(graph))

    print(f'Reallocation took {n_reallocation_cycles} iterations to complete.')
    print(f'A total of {n_state_cycles} cycles in the state graph resulted.')

def main():
    try:
        _, infile = sys.argv
    except:
        print(f'usage: {sys.argv[0]} <input filename>')
        exit(1)

    states = get_reallocation_graph(infile)
    print_solution(states)


if __name__ == '__main__':
    main()
