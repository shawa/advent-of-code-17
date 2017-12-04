from turtle import *
from collections import defaultdict
from itertools import product
import random

stepsize = 70

mem = defaultdict(int)
sequence = []

FOUND = False
TARGET = 0

STROKE_COLOR = '#ff8888'
SUPREME = "#d02120"

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
    write(new, align='right', font=('Futura', 17, 'italic'))
    pencolor(STROKE_COLOR)


def spiral(target=100):
    global TARGET
    global FOUND

    TARGET = target

    mem[position()] = 1

    i = 0
    done = False
    while not done:
        i = i + 1
        for _ in range(2):
            for _ in range(i):
                step()
                if FOUND:
                    return

            left(90)


def setup():
    fillcolor(STROKE_COLOR)
    shape('classic')
    shapesize(1, 1)
    speed('normal')
    pencolor(STROKE_COLOR)
    bgcolor(SUPREME)
    width(2)
    pendown()


def random_walk():
    while True:
        random.choice((left, right))(random.randint(1, 80))
        forward(5)

def main(target=368078):
    setup()
    spiral(target)
    random_walk()


if __name__ == '__main__':
    main()
