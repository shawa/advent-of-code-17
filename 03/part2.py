#!/usr/bin/env python3 

from turtle import *
from collections import defaultdict
from itertools import product
import random
import sys

stepsize = 70

mem = defaultdict(int)
sequence = []

FOUND = False
TARGET = 0
FONT = 'Futura', 17, 'italic'
STROKE_COLOR = '#ff8888'
SUPREME = "#d02120"

fillcolor(STROKE_COLOR)
pencolor(STROKE_COLOR)
bgcolor(SUPREME)
width(3)


def position():
    corrected = tuple(int(p) for p in pos())
    setpos(corrected)
    return corrected


def adjacents(x_y):
    def offsets(x):
        return tuple([x + (n * stepsize) for n in (-1, 0, 1)])
    x, y = x_y
    xs = offsets(x)
    ys = offsets(y)
    return tuple(product(xs, ys))
   

def step():
    global FOUND
    forward(stepsize)

    pt = position()
    friends = [mem[p] for p in adjacents(pt)]
    new = sum(friends)

    mem[pt] = new
    sequence.append(new)

    FOUND = new > TARGET

    pencolor('#000000' if FOUND else '#ffffff')
    write(new, align='right', font=FONT)
    pencolor(STROKE_COLOR)


def spiral(target=100):
    global TARGET
    global FOUND

    TARGET = target

    mem[position()] = 1

    pendown()

    side_length = 0
    while True:
        side_length = side_length + 1
        for _ in range(2):
            for _ in range(side_length):
                step()
                if FOUND:
                    return

            left(90)


def main(target=368078):
    spiral(target)
    while True:
        random.choice((left, right))(random.randint(1, 50))
        forward(5)


if __name__ == '__main__':
    try:
        n = int(sys.argv[1])
        main(n)
    except:
        main()

