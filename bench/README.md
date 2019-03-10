# Benchmark

Benchmark run from 2019-03-10 16:45:45.012774Z UTC

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
    <td style="white-space: nowrap; text-align: right">47.62 K</td>
    <td style="white-space: nowrap; text-align: right">21.00 μs</td>
    <td style="white-space: nowrap; text-align: right">±111.32%</td>
    <td style="white-space: nowrap; text-align: right">19 μs</td>
    <td style="white-space: nowrap; text-align: right">44 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">25.94 K</td>
    <td style="white-space: nowrap; text-align: right">38.55 μs</td>
    <td style="white-space: nowrap; text-align: right">±56.19%</td>
    <td style="white-space: nowrap; text-align: right">35 μs</td>
    <td style="white-space: nowrap; text-align: right">185 μs</td>
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
    <td style="white-space: nowrap;text-align: right">47.62 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">25.94 K</td>
    <td style="white-space: nowrap; text-align: right">1.84x</td>
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
    <td style="white-space: nowrap; text-align: right">387.47 K</td>
    <td style="white-space: nowrap; text-align: right">2.58 μs</td>
    <td style="white-space: nowrap; text-align: right">±1288.18%</td>
    <td style="white-space: nowrap; text-align: right">2 μs</td>
    <td style="white-space: nowrap; text-align: right">3 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">144.47 K</td>
    <td style="white-space: nowrap; text-align: right">6.92 μs</td>
    <td style="white-space: nowrap; text-align: right">±495.14%</td>
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
    <td style="white-space: nowrap;text-align: right">387.47 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">144.47 K</td>
    <td style="white-space: nowrap; text-align: right">2.68x</td>
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
    <td style="white-space: nowrap; text-align: right">421.87 μs</td>
    <td style="white-space: nowrap; text-align: right">±27.90%</td>
    <td style="white-space: nowrap; text-align: right">396 μs</td>
    <td style="white-space: nowrap; text-align: right">613 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">1.45 K</td>
    <td style="white-space: nowrap; text-align: right">691.80 μs</td>
    <td style="white-space: nowrap; text-align: right">±16.32%</td>
    <td style="white-space: nowrap; text-align: right">632 μs</td>
    <td style="white-space: nowrap; text-align: right">994 μs</td>
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
    <td style="white-space: nowrap; text-align: right">1.45 K</td>
    <td style="white-space: nowrap; text-align: right">1.64x</td>
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
    <td style="white-space: nowrap; text-align: right">246.44 K</td>
    <td style="white-space: nowrap; text-align: right">4.06 μs</td>
    <td style="white-space: nowrap; text-align: right">±649.64%</td>
    <td style="white-space: nowrap; text-align: right">4 μs</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">155.99 K</td>
    <td style="white-space: nowrap; text-align: right">6.41 μs</td>
    <td style="white-space: nowrap; text-align: right">±573.11%</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
    <td style="white-space: nowrap; text-align: right">15 μs</td>
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
    <td style="white-space: nowrap;text-align: right">246.44 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">155.99 K</td>
    <td style="white-space: nowrap; text-align: right">1.58x</td>
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
    <td style="white-space: nowrap; text-align: right">50.65 K</td>
    <td style="white-space: nowrap; text-align: right">19.74 μs</td>
    <td style="white-space: nowrap; text-align: right">±122.15%</td>
    <td style="white-space: nowrap; text-align: right">18 μs</td>
    <td style="white-space: nowrap; text-align: right">37 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">49.51 K</td>
    <td style="white-space: nowrap; text-align: right">20.20 μs</td>
    <td style="white-space: nowrap; text-align: right">±64.75%</td>
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
    <td style="white-space: nowrap;text-align: right">50.65 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">49.51 K</td>
    <td style="white-space: nowrap; text-align: right">1.02x</td>
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
    <td style="white-space: nowrap; text-align: right">178.81 K</td>
    <td style="white-space: nowrap; text-align: right">5.59 μs</td>
    <td style="white-space: nowrap; text-align: right">±546.45%</td>
    <td style="white-space: nowrap; text-align: right">5 μs</td>
    <td style="white-space: nowrap; text-align: right">8 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">115.58 K</td>
    <td style="white-space: nowrap; text-align: right">8.65 μs</td>
    <td style="white-space: nowrap; text-align: right">±389.08%</td>
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
    <td style="white-space: nowrap;text-align: right">178.81 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">115.58 K</td>
    <td style="white-space: nowrap; text-align: right">1.55x</td>
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
    <td style="white-space: nowrap; text-align: right">298.05 K</td>
    <td style="white-space: nowrap; text-align: right">3.36 μs</td>
    <td style="white-space: nowrap; text-align: right">±1316.95%</td>
    <td style="white-space: nowrap; text-align: right">3 μs</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">146.95 K</td>
    <td style="white-space: nowrap; text-align: right">6.81 μs</td>
    <td style="white-space: nowrap; text-align: right">±489.40%</td>
    <td style="white-space: nowrap; text-align: right">6 μs</td>
    <td style="white-space: nowrap; text-align: right">13 μs</td>
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
    <td style="white-space: nowrap;text-align: right">298.05 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">146.95 K</td>
    <td style="white-space: nowrap; text-align: right">2.03x</td>
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
    <td style="white-space: nowrap; text-align: right">299.50 K</td>
    <td style="white-space: nowrap; text-align: right">3.34 μs</td>
    <td style="white-space: nowrap; text-align: right">±1274.18%</td>
    <td style="white-space: nowrap; text-align: right">3 μs</td>
    <td style="white-space: nowrap; text-align: right">5 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">113.74 K</td>
    <td style="white-space: nowrap; text-align: right">8.79 μs</td>
    <td style="white-space: nowrap; text-align: right">±394.84%</td>
    <td style="white-space: nowrap; text-align: right">8 μs</td>
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
    <td style="white-space: nowrap;text-align: right">299.50 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">113.74 K</td>
    <td style="white-space: nowrap; text-align: right">2.63x</td>
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
    <td style="white-space: nowrap; text-align: right">362.22 K</td>
    <td style="white-space: nowrap; text-align: right">2.76 μs</td>
    <td style="white-space: nowrap; text-align: right">±1632.02%</td>
    <td style="white-space: nowrap; text-align: right">2 μs</td>
    <td style="white-space: nowrap; text-align: right">5 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">135.05 K</td>
    <td style="white-space: nowrap; text-align: right">7.40 μs</td>
    <td style="white-space: nowrap; text-align: right">±478.22%</td>
    <td style="white-space: nowrap; text-align: right">7 μs</td>
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
    <td style="white-space: nowrap;text-align: right">362.22 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">135.05 K</td>
    <td style="white-space: nowrap; text-align: right">2.68x</td>
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
    <td style="white-space: nowrap; text-align: right">28.37</td>
    <td style="white-space: nowrap; text-align: right">35.24 ms</td>
    <td style="white-space: nowrap; text-align: right">±4.88%</td>
    <td style="white-space: nowrap; text-align: right">34.83 ms</td>
    <td style="white-space: nowrap; text-align: right">40.84 ms</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">11.31</td>
    <td style="white-space: nowrap; text-align: right">88.42 ms</td>
    <td style="white-space: nowrap; text-align: right">±5.67%</td>
    <td style="white-space: nowrap; text-align: right">86.93 ms</td>
    <td style="white-space: nowrap; text-align: right">114.74 ms</td>
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
    <td style="white-space: nowrap;text-align: right">28.37</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">11.31</td>
    <td style="white-space: nowrap; text-align: right">2.51x</td>
  </tr>
</table>


<hr/>

