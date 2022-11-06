#!/bin/bash

# Author: Dmitry Mitrofanov
# Group: ICS8-93

mkdir -pv ./run
cd ./run
mkdir -pv ./tmp
ln -s ../data/ ./data
ln -s ../input/ ./in
ln -s ../output/ ./out
ln -s ../tools/armake/bin/ ./src
# start the main fuzzer
afl-fuzz -t 2000 -i ./in -o ./out -M f1 ./src/armake
# start parallel child fuzzers
afl-fuzz -t 2000 -i ./in -o ./out -S f2 ./src/armake
afl-fuzz -t 2000 -i ./in -o ./out -S f3 ./src/armake
afl-fuzz -t 2000 -i ./in -o ./out -S f4 ./src/armake

rm -rf ./run