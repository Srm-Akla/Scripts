#!/bin/python3

vowels = ["a", "e", "i", "o", "u"]

for i in vowels:
    for j in vowels:
        for k in vowels:
            print("h{}n{}{}?".format(i,j,k))
