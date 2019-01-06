Date: 2019/01/06
```
Operating System: macOS"
CPU Information: Intel(R) Core(TM) i7-4770HQ CPU @ 2.20GHz
Number of Available Cores: 8
Available memory: 16 GB
Elixir 1.7.4
Erlang 21.1

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 μs
parallel: 4
inputs: invalid, valid
Estimated total run time: 28 s


Benchmarking ExJsonSchema with input invalid...
Benchmarking ExJsonSchema with input valid...
Benchmarking JsonXema with input invalid...
Benchmarking JsonXema with input valid...

##### With input invalid #####
Name                   ips        average  deviation         median         99th %
JsonXema          155.89 K        6.41 μs   ±229.46%           6 μs          12 μs
ExJsonSchema       96.39 K       10.37 μs   ±126.56%           9 μs          29 μs

Comparison:
JsonXema          155.89 K
ExJsonSchema       96.39 K - 1.62x slower

##### With input valid #####
Name                   ips        average  deviation         median         99th %
JsonXema          252.62 K        3.96 μs   ±697.96%           4 μs           7 μs
ExJsonSchema      109.12 K        9.16 μs   ±213.31%           8 μs          28 μs

Comparison:
JsonXema          252.62 K
ExJsonSchema      109.12 K - 2.32x slower
```
