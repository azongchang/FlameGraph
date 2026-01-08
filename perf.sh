#!/bin/bash

duration=${1:-10}
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
mkdir -p "$timestamp" && cd "$timestamp"
sudo perf record -F 999 -a -g -- sleep "$duration"
sudo perf script > out.perf
../stackcollapse-perf.pl out.perf > out.folded
../flamegraph.pl out.folded > out.svg

