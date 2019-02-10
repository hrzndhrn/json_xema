# Benchmark

The benchmark test is not representative for now, because the benchmark test
doesn't cover the whole code.

## Example run (2019/02/04)

```
Operating System: macOS"
CPU Information: Intel(R) Core(TM) i7-4770HQ CPU @ 2.20GHz
Number of Available Cores: 8
Available memory: 16 GB
Elixir 1.8.0
Erlang 21.1

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 μs
parallel: 4
inputs: basic.json, chrome_extension.json, coordinates.json, definitions.json,
email.json, emails.json, enum.json, hostname.json, integer.json, integers.json,
ipv4_list.json, pos_neg_even.json, string.json, string_length.json
Estimated total run time: 3.27 min


Benchmarking ExJsonSchema with input basic.json...
Benchmarking ExJsonSchema with input chrome_extension.json...
Benchmarking ExJsonSchema with input coordinates.json...
Benchmarking ExJsonSchema with input definitions.json...
Benchmarking ExJsonSchema with input email.json...
Benchmarking ExJsonSchema with input emails.json...
Benchmarking ExJsonSchema with input enum.json...
Benchmarking ExJsonSchema with input hostname.json...
Benchmarking ExJsonSchema with input integer.json...
Benchmarking ExJsonSchema with input integers.json...
Benchmarking ExJsonSchema with input ipv4_list.json...
Benchmarking ExJsonSchema with input pos_neg_even.json...
Benchmarking ExJsonSchema with input string.json...
Benchmarking ExJsonSchema with input string_length.json...
Benchmarking JsonXema with input basic.json...
Benchmarking JsonXema with input chrome_extension.json...
Benchmarking JsonXema with input coordinates.json...
Benchmarking JsonXema with input definitions.json...
Benchmarking JsonXema with input email.json...
Benchmarking JsonXema with input emails.json...
Benchmarking JsonXema with input enum.json...
Benchmarking JsonXema with input hostname.json...
Benchmarking JsonXema with input integer.json...
Benchmarking JsonXema with input integers.json...
Benchmarking JsonXema with input ipv4_list.json...
Benchmarking JsonXema with input pos_neg_even.json...
Benchmarking JsonXema with input string.json...
Benchmarking JsonXema with input string_length.json...

##### With input basic.json #####
Name                   ips        average  deviation         median       99th %
JsonXema          315.96 K        3.16 μs   ±939.18%           3 μs         6 μs
ExJsonSchema      107.46 K        9.31 μs   ±211.71%           8 μs        31 μs

Comparison:
JsonXema          315.96 K
ExJsonSchema      107.46 K - 2.94x slower

##### With input chrome_extension.json #####
Name                   ips        average  deviation         median       99th %
JsonXema           39.44 K       25.35 μs    ±52.72%          23 μs        64 μs
ExJsonSchema       22.28 K       44.89 μs    ±46.01%          38 μs       123 μs

Comparison:
JsonXema           39.44 K
ExJsonSchema       22.28 K - 1.77x slower

##### With input coordinates.json #####
Name                   ips        average  deviation         median       99th %
JsonXema          309.06 K        3.24 μs   ±997.72%           3 μs         6 μs
ExJsonSchema       73.73 K       13.56 μs   ±186.02%          12 μs        52 μs

Comparison:
JsonXema          309.06 K
ExJsonSchema       73.73 K - 4.19x slower

##### With input definitions.json #####
Name                   ips        average  deviation         median       99th %
JsonXema          205.47 K        4.87 μs   ±496.64%           4 μs         9 μs
ExJsonSchema       56.82 K       17.60 μs   ±186.72%          15 μs        73 μs

Comparison:
JsonXema          205.47 K
ExJsonSchema       56.82 K - 3.62x slower

##### With input email.json #####
Name                   ips        average  deviation         median       99th %
ExJsonSchema      384.77 K        2.60 μs   ±941.52%           2 μs         7 μs
JsonXema          221.63 K        4.51 μs   ±761.70%           3 μs        15 μs

Comparison:
ExJsonSchema      384.77 K
JsonXema          221.63 K - 1.74x slower

##### With input emails.json #####
Name                   ips        average  deviation         median       99th %
ExJsonSchema       80.80 K       12.38 μs   ±128.72%          11 μs        44 μs
JsonXema           57.05 K       17.53 μs   ±193.59%          11 μs        55 μs

Comparison:
ExJsonSchema       80.80 K
JsonXema           57.05 K - 1.42x slower

##### With input enum.json #####
Name                   ips        average  deviation         median       99th %
JsonXema          151.71 K        6.59 μs   ±275.35%           5 μs        21 μs
ExJsonSchema      116.47 K        8.59 μs   ±251.40%           7 μs        27 μs

Comparison:
JsonXema          151.71 K
ExJsonSchema      116.47 K - 1.30x slower

##### With input hostname.json #####
Name                   ips        average  deviation         median       99th %
JsonXema          370.24 K        2.70 μs  ±1006.39%           2 μs         5 μs
ExJsonSchema      283.52 K        3.53 μs   ±851.14%           3 μs         7 μs

Comparison:
JsonXema          370.24 K
ExJsonSchema      283.52 K - 1.31x slower

##### With input integer.json #####
Name                   ips        average  deviation         median       99th %
JsonXema            1.44 M        0.69 μs   ±672.93%        0.60 μs      1.30 μs
ExJsonSchema        1.32 M        0.76 μs   ±583.80%        0.60 μs      2.28 μs

Comparison:
JsonXema            1.44 M
ExJsonSchema        1.32 M - 1.10x slower

##### With input integers.json #####
Name                   ips        average  deviation         median       99th %
JsonXema          161.06 K        6.21 μs   ±419.37%           6 μs        11 μs
ExJsonSchema       78.26 K       12.78 μs   ±160.00%          10 μs        67 μs

Comparison:
JsonXema          161.06 K
ExJsonSchema       78.26 K - 2.06x slower

##### With input ipv4_list.json #####
Name                   ips        average  deviation         median       99th %
JsonXema           90.52 K       11.05 μs   ±120.70%          10 μs        23 μs
ExJsonSchema       40.47 K       24.71 μs   ±127.23%          22 μs        86 μs

Comparison:
JsonXema           90.52 K
ExJsonSchema       40.47 K - 2.24x slower

##### With input pos_neg_even.json #####
Name                   ips        average  deviation         median       99th %
JsonXema          249.99 K        4.00 μs   ±833.50%           4 μs         7 μs
ExJsonSchema       70.80 K       14.13 μs   ±138.50%          12 μs        51 μs

Comparison:
JsonXema          249.99 K
ExJsonSchema       70.80 K - 3.53x slower

##### With input string.json #####
Name                   ips        average  deviation         median       99th %
JsonXema            1.48 M        0.68 μs   ±507.78%        0.60 μs         2 μs
ExJsonSchema        1.03 M        0.97 μs   ±525.57%        0.70 μs      2.80 μs

Comparison:
JsonXema            1.48 M
ExJsonSchema        1.03 M - 1.44x slower

##### With input string_length.json #####
Name                   ips        average  deviation         median       99th %
ExJsonSchema      534.13 K        1.87 μs  ±1292.12%           2 μs         4 μs
JsonXema          447.16 K        2.24 μs  ±1112.03%           2 μs         7 μs

Comparison:
ExJsonSchema      534.13 K
JsonXema          447.16 K - 1.19x slower
```
