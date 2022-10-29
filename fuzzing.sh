#!/bin/bash

# Author: Dmitry Mitrofanov
# Group: ICS8-93

# start the main fuzzer
afl-fuzz -t 5000 -i ./input -o ./output -M f1 ./tools/armake/bin/armake
# start parallel child fuzzers
afl-fuzz -t 5000 -i ./input -o ./output -S f2 ./tools/armake/bin/armake
afl-fuzz -t 5000 -i ./input -o ./output -S f3 ./tools/armake/bin/armake
afl-fuzz -t 5000 -i ./input -o ./output -S f4 ./tools/armake/bin/armake