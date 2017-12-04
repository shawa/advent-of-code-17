from turtle import *
from time import sleep
from collections import defaultdict
from itertools import product

stepsize = 75

mem = defaultdict(int)
sequence = []

FOUND = False
TARGET = 0

def position():
    return tuple(p for p in pos())

def offsets(x):
    offs = -1, 0, 1
    return tuple([x + (n * stepsize) for n in offs])

def adjacents(x_y):
    x, y = x_y
    xs = offsets(x)
    ys = offsets(y)
    return tuple(product(xs, ys))
   

def turn(): 
    left(90)


def step():
    global FOUND
    print(position())
    forward(stepsize)
    setpos(int(x) for x in position())
    pt = position()
    adjacent_p = adjacents(pt)
    friends = [mem[p] for p in adjacent_p]
    new = sum(friends)
    FOUND = new > TARGET
    print(pt)
    print(friends)
    print(adjacent_p)
    print(new)
    sequence.append(new)
    pencolor('#ffffff')
    if FOUND:
        pencolor('#ddffdd')
    write(new, align='center', font=('Futura', 17, 'italic'))
    pencolor('#ffaaaa')
    mem[pt] = new


def end():
    sleep(999999)


def spiral(n=100):
    global TARGET
    global FOUND
    TARGET=n
    mem[pos()] = 1
    sleep(1)

    def go(i):
        for _ in range(2):
            for _ in range(i):
                step()
                if FOUND:
                    penup()
                    forward(stepsize)
                    sleep(0.5)
                    goto(0,0)
                    return True
            turn()
            sleep(0.05)

    i = 1
    done = False
    while not done:
        done = go(i)
        i = i + 1
        

fillcolor('#ffffff')
shape('classic')
shapesize(1, 1)
speed('normal')
pencolor('#ffaaaa')
bgcolor("#D02120")
pendown()
