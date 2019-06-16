# Benchmark

Benchmark run from 2019-06-16 09:12:35.192997Z UTC

## System

Benchmark suite executing on the following system:

<table style="width: 1%">
  <tr>
    <th style="width: 1%; white-space: nowrap">Operating System</th>
    <td>macOS</td>
  </tr><tr>
    <th style="white-space: nowrap">CPU Information</th>
    <td style="white-space: nowrap">Intel(R) Core(TM) i7-4770HQ CPU @ 2.20GHz</td>
  </tr><tr>
    <th style="white-space: nowrap">Number of Available Cores</th>
    <td style="white-space: nowrap">8</td>
  </tr><tr>
    <th style="white-space: nowrap">Available Memory</th>
    <td style="white-space: nowrap">16 GB</td>
  </tr><tr>
    <th style="white-space: nowrap">Elixir Version</th>
    <td style="white-space: nowrap">1.8.2</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">22.0</td>
  </tr>
</table>

## Configuration

Benchmark suite executing with the following configuration:

<table style="width: 1%">
  <tr>
    <th style="width: 1%">:time</th>
    <td style="white-space: nowrap">10 s</td>
  </tr><tr>
    <th>:parallel</th>
    <td style="white-space: nowrap">1</td>
  </tr><tr>
    <th>:warmup</th>
    <td style="white-space: nowrap">2 s</td>
  </tr>
</table>

## Statistics



__Input: chrome_extension.json__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">43.80 K</td>
    <td style="white-space: nowrap; text-align: right">22.83 μs</td>
    <td style="white-space: nowrap; text-align: right">±85.68%</td>
    <td style="white-space: nowrap; text-align: right">21 μs</td>
    <td style="white-space: nowrap; text-align: right">54 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">26.11 K</td>
    <td style="white-space: nowrap; text-align: right">38.31 μs</td>
    <td style="white-space: nowrap; text-align: right">±52.00%</td>
    <td style="white-space: nowrap; text-align: right">35 μs</td>
    <td style="white-space: nowrap; text-align: right">178 μs</td>
  </tr>
</table>

Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">43.80 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">26.11 K</td>
    <td style="white-space: nowrap; text-align: right">1.68x</td>
  </tr>
</table>


<hr/>

__Input: coordinates.json__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">298.23 K</td>
    <td style="white-space: nowrap; text-align: right">3.35 μs</td>
    <td style="white-space: nowrap; text-align: right">±1075.22%</td>
    <td style="white-space: nowrap; text-align: right">3 μs</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">142.22 K</td>
    <td style="white-space: nowrap; text-align: right">7.03 μs</td>
    <td style="white-space: nowrap; text-align: right">±415.71%</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
    <td style="white-space: nowrap; text-align: right">16 μs</td>
  </tr>
</table>

Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">298.23 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">142.22 K</td>
    <td style="white-space: nowrap; text-align: right">2.1x</td>
  </tr>
</table>


<hr/>

__Input: draft04.json__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">2.27 K</td>
    <td style="white-space: nowrap; text-align: right">440.78 μs</td>
    <td style="white-space: nowrap; text-align: right">±16.89%</td>
    <td style="white-space: nowrap; text-align: right">419 μs</td>
    <td style="white-space: nowrap; text-align: right">701.15 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">1.47 K</td>
    <td style="white-space: nowrap; text-align: right">681.31 μs</td>
    <td style="white-space: nowrap; text-align: right">±11.97%</td>
    <td style="white-space: nowrap; text-align: right">681 μs</td>
    <td style="white-space: nowrap; text-align: right">949 μs</td>
  </tr>
</table>

Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">2.27 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">1.47 K</td>
    <td style="white-space: nowrap; text-align: right">1.55x</td>
  </tr>
</table>


<hr/>

__Input: enum.json__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">238.73 K</td>
    <td style="white-space: nowrap; text-align: right">4.19 μs</td>
    <td style="white-space: nowrap; text-align: right">±809.24%</td>
    <td style="white-space: nowrap; text-align: right">4 μs</td>
    <td style="white-space: nowrap; text-align: right">8 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">171.88 K</td>
    <td style="white-space: nowrap; text-align: right">5.82 μs</td>
    <td style="white-space: nowrap; text-align: right">±528.21%</td>
    <td style="white-space: nowrap; text-align: right">5 μs</td>
    <td style="white-space: nowrap; text-align: right">14 μs</td>
  </tr>
</table>

Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">238.73 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">171.88 K</td>
    <td style="white-space: nowrap; text-align: right">1.39x</td>
  </tr>
</table>


<hr/>

__Input: formats.json__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">51.01 K</td>
    <td style="white-space: nowrap; text-align: right">19.60 μs</td>
    <td style="white-space: nowrap; text-align: right">±94.97%</td>
    <td style="white-space: nowrap; text-align: right">18 μs</td>
    <td style="white-space: nowrap; text-align: right">33 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">47.55 K</td>
    <td style="white-space: nowrap; text-align: right">21.03 μs</td>
    <td style="white-space: nowrap; text-align: right">±152.48%</td>
    <td style="white-space: nowrap; text-align: right">20 μs</td>
    <td style="white-space: nowrap; text-align: right">34 μs</td>
  </tr>
</table>

Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap;text-align: right">51.01 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">47.55 K</td>
    <td style="white-space: nowrap; text-align: right">1.07x</td>
  </tr>
</table>


<hr/>

__Input: integers.json__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">126.31 K</td>
    <td style="white-space: nowrap; text-align: right">7.92 μs</td>
    <td style="white-space: nowrap; text-align: right">±306.09%</td>
    <td style="white-space: nowrap; text-align: right">8 μs</td>
    <td style="white-space: nowrap; text-align: right">17 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">95.27 K</td>
    <td style="white-space: nowrap; text-align: right">10.50 μs</td>
    <td style="white-space: nowrap; text-align: right">±249.10%</td>
    <td style="white-space: nowrap; text-align: right">9 μs</td>
    <td style="white-space: nowrap; text-align: right">20 μs</td>
  </tr>
</table>

Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">126.31 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">95.27 K</td>
    <td style="white-space: nowrap; text-align: right">1.33x</td>
  </tr>
</table>


<hr/>

__Input: pos_neg_even.json__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">263.09 K</td>
    <td style="white-space: nowrap; text-align: right">3.80 μs</td>
    <td style="white-space: nowrap; text-align: right">±775.17%</td>
    <td style="white-space: nowrap; text-align: right">4 μs</td>
    <td style="white-space: nowrap; text-align: right">5 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">158.20 K</td>
    <td style="white-space: nowrap; text-align: right">6.32 μs</td>
    <td style="white-space: nowrap; text-align: right">±487.51%</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
    <td style="white-space: nowrap; text-align: right">15 μs</td>
  </tr>
</table>

Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">263.09 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">158.20 K</td>
    <td style="white-space: nowrap; text-align: right">1.66x</td>
  </tr>
</table>


<hr/>

__Input: pos_neg_even_def.json__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">259.82 K</td>
    <td style="white-space: nowrap; text-align: right">3.85 μs</td>
    <td style="white-space: nowrap; text-align: right">±859.50%</td>
    <td style="white-space: nowrap; text-align: right">4 μs</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">116.16 K</td>
    <td style="white-space: nowrap; text-align: right">8.61 μs</td>
    <td style="white-space: nowrap; text-align: right">±375.21%</td>
    <td style="white-space: nowrap; text-align: right">8 μs</td>
    <td style="white-space: nowrap; text-align: right">18 μs</td>
  </tr>
</table>

Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">259.82 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">116.16 K</td>
    <td style="white-space: nowrap; text-align: right">2.24x</td>
  </tr>
</table>


<hr/>

__Input: user.json__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">321.49 K</td>
    <td style="white-space: nowrap; text-align: right">3.11 μs</td>
    <td style="white-space: nowrap; text-align: right">±1021.84%</td>
    <td style="white-space: nowrap; text-align: right">3 μs</td>
    <td style="white-space: nowrap; text-align: right">4 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">137.27 K</td>
    <td style="white-space: nowrap; text-align: right">7.29 μs</td>
    <td style="white-space: nowrap; text-align: right">±456.99%</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
    <td style="white-space: nowrap; text-align: right">17 μs</td>
  </tr>
</table>

Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">321.49 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">137.27 K</td>
    <td style="white-space: nowrap; text-align: right">2.34x</td>
  </tr>
</table>


<hr/>

__Input: users.json__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">24.87</td>
    <td style="white-space: nowrap; text-align: right">40.21 ms</td>
    <td style="white-space: nowrap; text-align: right">±3.54%</td>
    <td style="white-space: nowrap; text-align: right">39.96 ms</td>
    <td style="white-space: nowrap; text-align: right">47.86 ms</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">11.09</td>
    <td style="white-space: nowrap; text-align: right">90.21 ms</td>
    <td style="white-space: nowrap; text-align: right">±3.87%</td>
    <td style="white-space: nowrap; text-align: right">89.18 ms</td>
    <td style="white-space: nowrap; text-align: right">111.05 ms</td>
  </tr>
</table>

Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">24.87</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">11.09</td>
    <td style="white-space: nowrap; text-align: right">2.24x</td>
  </tr>
</table>


<hr/>

