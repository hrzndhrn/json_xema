# Benchmark

Benchmark run from 2019-03-10 17:23:43.745812Z UTC

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
    <td style="white-space: nowrap">1.8.1</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">21.1</td>
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
    <td style="white-space: nowrap; text-align: right">48.52 K</td>
    <td style="white-space: nowrap; text-align: right">20.61 μs</td>
    <td style="white-space: nowrap; text-align: right">±99.75%</td>
    <td style="white-space: nowrap; text-align: right">19 μs</td>
    <td style="white-space: nowrap; text-align: right">40 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">26.86 K</td>
    <td style="white-space: nowrap; text-align: right">37.23 μs</td>
    <td style="white-space: nowrap; text-align: right">±53.04%</td>
    <td style="white-space: nowrap; text-align: right">34 μs</td>
    <td style="white-space: nowrap; text-align: right">183 μs</td>
  </tr>
</table>

Comparsion
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">48.52 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">26.86 K</td>
    <td style="white-space: nowrap; text-align: right">1.81x</td>
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
    <td style="white-space: nowrap; text-align: right">394.66 K</td>
    <td style="white-space: nowrap; text-align: right">2.53 μs</td>
    <td style="white-space: nowrap; text-align: right">±1213.96%</td>
    <td style="white-space: nowrap; text-align: right">2 μs</td>
    <td style="white-space: nowrap; text-align: right">3 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">150.00 K</td>
    <td style="white-space: nowrap; text-align: right">6.67 μs</td>
    <td style="white-space: nowrap; text-align: right">±490.18%</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
    <td style="white-space: nowrap; text-align: right">10 μs</td>
  </tr>
</table>

Comparsion
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">394.66 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">150.00 K</td>
    <td style="white-space: nowrap; text-align: right">2.63x</td>
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
    <td style="white-space: nowrap; text-align: right">2.37 K</td>
    <td style="white-space: nowrap; text-align: right">421.12 μs</td>
    <td style="white-space: nowrap; text-align: right">±29.07%</td>
    <td style="white-space: nowrap; text-align: right">397 μs</td>
    <td style="white-space: nowrap; text-align: right">608 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">1.40 K</td>
    <td style="white-space: nowrap; text-align: right">714.11 μs</td>
    <td style="white-space: nowrap; text-align: right">±18.06%</td>
    <td style="white-space: nowrap; text-align: right">650 μs</td>
    <td style="white-space: nowrap; text-align: right">1124.42 μs</td>
  </tr>
</table>

Comparsion
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">2.37 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">1.40 K</td>
    <td style="white-space: nowrap; text-align: right">1.7x</td>
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
    <td style="white-space: nowrap; text-align: right">256.05 K</td>
    <td style="white-space: nowrap; text-align: right">3.91 μs</td>
    <td style="white-space: nowrap; text-align: right">±745.37%</td>
    <td style="white-space: nowrap; text-align: right">4 μs</td>
    <td style="white-space: nowrap; text-align: right">5 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">153.09 K</td>
    <td style="white-space: nowrap; text-align: right">6.53 μs</td>
    <td style="white-space: nowrap; text-align: right">±515.14%</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
    <td style="white-space: nowrap; text-align: right">16 μs</td>
  </tr>
</table>

Comparsion
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">256.05 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">153.09 K</td>
    <td style="white-space: nowrap; text-align: right">1.67x</td>
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
    <td style="white-space: nowrap; text-align: right">51.66 K</td>
    <td style="white-space: nowrap; text-align: right">19.36 μs</td>
    <td style="white-space: nowrap; text-align: right">±117.56%</td>
    <td style="white-space: nowrap; text-align: right">18 μs</td>
    <td style="white-space: nowrap; text-align: right">30 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">49.84 K</td>
    <td style="white-space: nowrap; text-align: right">20.06 μs</td>
    <td style="white-space: nowrap; text-align: right">±63.87%</td>
    <td style="white-space: nowrap; text-align: right">19 μs</td>
    <td style="white-space: nowrap; text-align: right">31 μs</td>
  </tr>
</table>

Comparsion
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap;text-align: right">51.66 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">49.84 K</td>
    <td style="white-space: nowrap; text-align: right">1.04x</td>
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
    <td style="white-space: nowrap; text-align: right">190.49 K</td>
    <td style="white-space: nowrap; text-align: right">5.25 μs</td>
    <td style="white-space: nowrap; text-align: right">±501.66%</td>
    <td style="white-space: nowrap; text-align: right">5 μs</td>
    <td style="white-space: nowrap; text-align: right">8 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">115.30 K</td>
    <td style="white-space: nowrap; text-align: right">8.67 μs</td>
    <td style="white-space: nowrap; text-align: right">±380.85%</td>
    <td style="white-space: nowrap; text-align: right">7 μs</td>
    <td style="white-space: nowrap; text-align: right">17 μs</td>
  </tr>
</table>

Comparsion
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">190.49 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">115.30 K</td>
    <td style="white-space: nowrap; text-align: right">1.65x</td>
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
    <td style="white-space: nowrap; text-align: right">317.56 K</td>
    <td style="white-space: nowrap; text-align: right">3.15 μs</td>
    <td style="white-space: nowrap; text-align: right">±1267.46%</td>
    <td style="white-space: nowrap; text-align: right">3 μs</td>
    <td style="white-space: nowrap; text-align: right">4 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">138.67 K</td>
    <td style="white-space: nowrap; text-align: right">7.21 μs</td>
    <td style="white-space: nowrap; text-align: right">±443.76%</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
    <td style="white-space: nowrap; text-align: right">16 μs</td>
  </tr>
</table>

Comparsion
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">317.56 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">138.67 K</td>
    <td style="white-space: nowrap; text-align: right">2.29x</td>
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
    <td style="white-space: nowrap; text-align: right">318.75 K</td>
    <td style="white-space: nowrap; text-align: right">3.14 μs</td>
    <td style="white-space: nowrap; text-align: right">±1148.93%</td>
    <td style="white-space: nowrap; text-align: right">3 μs</td>
    <td style="white-space: nowrap; text-align: right">4 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">112.00 K</td>
    <td style="white-space: nowrap; text-align: right">8.93 μs</td>
    <td style="white-space: nowrap; text-align: right">±263.91%</td>
    <td style="white-space: nowrap; text-align: right">8 μs</td>
    <td style="white-space: nowrap; text-align: right">18 μs</td>
  </tr>
</table>

Comparsion
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">318.75 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">112.00 K</td>
    <td style="white-space: nowrap; text-align: right">2.85x</td>
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
    <td style="white-space: nowrap; text-align: right">389.12 K</td>
    <td style="white-space: nowrap; text-align: right">2.57 μs</td>
    <td style="white-space: nowrap; text-align: right">±1532.62%</td>
    <td style="white-space: nowrap; text-align: right">2 μs</td>
    <td style="white-space: nowrap; text-align: right">3 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">137.94 K</td>
    <td style="white-space: nowrap; text-align: right">7.25 μs</td>
    <td style="white-space: nowrap; text-align: right">±313.71%</td>
    <td style="white-space: nowrap; text-align: right">7 μs</td>
    <td style="white-space: nowrap; text-align: right">10 μs</td>
  </tr>
</table>

Comparsion
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">389.12 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">137.94 K</td>
    <td style="white-space: nowrap; text-align: right">2.82x</td>
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
    <td style="white-space: nowrap; text-align: right">30.02</td>
    <td style="white-space: nowrap; text-align: right">33.31 ms</td>
    <td style="white-space: nowrap; text-align: right">±4.54%</td>
    <td style="white-space: nowrap; text-align: right">33.11 ms</td>
    <td style="white-space: nowrap; text-align: right">38.09 ms</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">11.30</td>
    <td style="white-space: nowrap; text-align: right">88.47 ms</td>
    <td style="white-space: nowrap; text-align: right">±5.19%</td>
    <td style="white-space: nowrap; text-align: right">87.08 ms</td>
    <td style="white-space: nowrap; text-align: right">113.37 ms</td>
  </tr>
</table>

Comparsion
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap;text-align: right">30.02</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">11.30</td>
    <td style="white-space: nowrap; text-align: right">2.66x</td>
  </tr>
</table>


<hr/>

