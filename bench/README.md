Benchmark

Benchmark run from 2025-10-08 23:45:54.059029Z UTC

## System

Benchmark suite executing on the following system:

<table style="width: 1%">
  <tr>
    <th style="width: 1%; white-space: nowrap">Operating System</th>
    <td>macOS</td>
  </tr><tr>
    <th style="white-space: nowrap">CPU Information</th>
    <td style="white-space: nowrap">Apple M3 Ultra</td>
  </tr><tr>
    <th style="white-space: nowrap">Number of Available Cores</th>
    <td style="white-space: nowrap">28</td>
  </tr><tr>
    <th style="white-space: nowrap">Available Memory</th>
    <td style="white-space: nowrap">256 GB</td>
  </tr><tr>
    <th style="white-space: nowrap">Elixir Version</th>
    <td style="white-space: nowrap">1.18.3</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">27.3</td>
  </tr>
</table>

## Configuration

Benchmark suite executing with the following configuration:

<table style="width: 1%">
  <tr>
    <th style="width: 1%">:time</th>
    <td style="white-space: nowrap">1 s</td>
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
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">512.53 K</td>
    <td style="white-space: nowrap; text-align: right">1.95 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;470.16%</td>
    <td style="white-space: nowrap; text-align: right">1.83 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">2.04 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">496.12 K</td>
    <td style="white-space: nowrap; text-align: right">2.02 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;411.33%</td>
    <td style="white-space: nowrap; text-align: right">1.92 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">2.21 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">212.36 K</td>
    <td style="white-space: nowrap; text-align: right">4.71 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;368.77%</td>
    <td style="white-space: nowrap; text-align: right">3.88 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">5.50 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">78.05 K</td>
    <td style="white-space: nowrap; text-align: right">12.81 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;193.29%</td>
    <td style="white-space: nowrap; text-align: right">8.42 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">163.29 &micro;s</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap;text-align: right">512.53 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">496.12 K</td>
    <td style="white-space: nowrap; text-align: right">1.03x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">212.36 K</td>
    <td style="white-space: nowrap; text-align: right">2.41x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">78.05 K</td>
    <td style="white-space: nowrap; text-align: right">6.57x</td>
  </tr>

</table>




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
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">2.53 M</td>
    <td style="white-space: nowrap; text-align: right">395.06 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2413.00%</td>
    <td style="white-space: nowrap; text-align: right">375 ns</td>
    <td style="white-space: nowrap; text-align: right">459 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">2.27 M</td>
    <td style="white-space: nowrap; text-align: right">441.39 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1476.33%</td>
    <td style="white-space: nowrap; text-align: right">417 ns</td>
    <td style="white-space: nowrap; text-align: right">542 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.68 M</td>
    <td style="white-space: nowrap; text-align: right">595.24 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1268.97%</td>
    <td style="white-space: nowrap; text-align: right">542 ns</td>
    <td style="white-space: nowrap; text-align: right">709 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.64 M</td>
    <td style="white-space: nowrap; text-align: right">1561.95 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;199.95%</td>
    <td style="white-space: nowrap; text-align: right">1458 ns</td>
    <td style="white-space: nowrap; text-align: right">2292 ns</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap;text-align: right">2.53 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">2.27 M</td>
    <td style="white-space: nowrap; text-align: right">1.12x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.68 M</td>
    <td style="white-space: nowrap; text-align: right">1.51x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.64 M</td>
    <td style="white-space: nowrap; text-align: right">3.95x</td>
  </tr>

</table>




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
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">39.91 K</td>
    <td style="white-space: nowrap; text-align: right">25.06 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;8.26%</td>
    <td style="white-space: nowrap; text-align: right">24.83 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">30.29 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">39.82 K</td>
    <td style="white-space: nowrap; text-align: right">25.11 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;5.63%</td>
    <td style="white-space: nowrap; text-align: right">25 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">28.29 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">11.28 K</td>
    <td style="white-space: nowrap; text-align: right">88.68 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;4.29%</td>
    <td style="white-space: nowrap; text-align: right">88.17 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">101.17 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">6.10 K</td>
    <td style="white-space: nowrap; text-align: right">163.99 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;5.87%</td>
    <td style="white-space: nowrap; text-align: right">162.71 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">216.36 &micro;s</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap;text-align: right">39.91 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">39.82 K</td>
    <td style="white-space: nowrap; text-align: right">1.0x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">11.28 K</td>
    <td style="white-space: nowrap; text-align: right">3.54x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">6.10 K</td>
    <td style="white-space: nowrap; text-align: right">6.54x</td>
  </tr>

</table>




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
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">2.09 M</td>
    <td style="white-space: nowrap; text-align: right">478.66 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1865.56%</td>
    <td style="white-space: nowrap; text-align: right">458 ns</td>
    <td style="white-space: nowrap; text-align: right">584 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.98 M</td>
    <td style="white-space: nowrap; text-align: right">504.14 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1440.37%</td>
    <td style="white-space: nowrap; text-align: right">500 ns</td>
    <td style="white-space: nowrap; text-align: right">625 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.33 M</td>
    <td style="white-space: nowrap; text-align: right">753.82 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;940.08%</td>
    <td style="white-space: nowrap; text-align: right">708 ns</td>
    <td style="white-space: nowrap; text-align: right">875 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.69 M</td>
    <td style="white-space: nowrap; text-align: right">1459.81 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;294.45%</td>
    <td style="white-space: nowrap; text-align: right">1292 ns</td>
    <td style="white-space: nowrap; text-align: right">2416 ns</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap;text-align: right">2.09 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.98 M</td>
    <td style="white-space: nowrap; text-align: right">1.05x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.33 M</td>
    <td style="white-space: nowrap; text-align: right">1.57x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.69 M</td>
    <td style="white-space: nowrap; text-align: right">3.05x</td>
  </tr>

</table>




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
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">1.59 M</td>
    <td style="white-space: nowrap; text-align: right">0.63 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1165.96%</td>
    <td style="white-space: nowrap; text-align: right">0.63 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">0.75 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.47 M</td>
    <td style="white-space: nowrap; text-align: right">0.68 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1167.52%</td>
    <td style="white-space: nowrap; text-align: right">0.67 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">0.79 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.140 M</td>
    <td style="white-space: nowrap; text-align: right">7.14 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;24.53%</td>
    <td style="white-space: nowrap; text-align: right">6.92 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">12.17 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">0.117 M</td>
    <td style="white-space: nowrap; text-align: right">8.51 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;17.76%</td>
    <td style="white-space: nowrap; text-align: right">8.46 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">9.71 &micro;s</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap;text-align: right">1.59 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.47 M</td>
    <td style="white-space: nowrap; text-align: right">1.08x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.140 M</td>
    <td style="white-space: nowrap; text-align: right">11.32x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">0.117 M</td>
    <td style="white-space: nowrap; text-align: right">13.5x</td>
  </tr>

</table>




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
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">1.96 M</td>
    <td style="white-space: nowrap; text-align: right">0.51 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1822.74%</td>
    <td style="white-space: nowrap; text-align: right">0.50 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">0.63 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.83 M</td>
    <td style="white-space: nowrap; text-align: right">0.55 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1207.26%</td>
    <td style="white-space: nowrap; text-align: right">0.54 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">0.67 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">0.66 M</td>
    <td style="white-space: nowrap; text-align: right">1.52 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;255.56%</td>
    <td style="white-space: nowrap; text-align: right">1.46 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">2.04 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.38 M</td>
    <td style="white-space: nowrap; text-align: right">2.66 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;176.90%</td>
    <td style="white-space: nowrap; text-align: right">2.25 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">11.79 &micro;s</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap;text-align: right">1.96 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.83 M</td>
    <td style="white-space: nowrap; text-align: right">1.07x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">0.66 M</td>
    <td style="white-space: nowrap; text-align: right">2.99x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.38 M</td>
    <td style="white-space: nowrap; text-align: right">5.23x</td>
  </tr>

</table>




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
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">2.38 M</td>
    <td style="white-space: nowrap; text-align: right">421.01 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1857.01%</td>
    <td style="white-space: nowrap; text-align: right">416 ns</td>
    <td style="white-space: nowrap; text-align: right">500 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">2.15 M</td>
    <td style="white-space: nowrap; text-align: right">464.90 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1307.97%</td>
    <td style="white-space: nowrap; text-align: right">458 ns</td>
    <td style="white-space: nowrap; text-align: right">583 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.37 M</td>
    <td style="white-space: nowrap; text-align: right">732.52 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;952.44%</td>
    <td style="white-space: nowrap; text-align: right">708 ns</td>
    <td style="white-space: nowrap; text-align: right">834 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.49 M</td>
    <td style="white-space: nowrap; text-align: right">2043.30 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;138.86%</td>
    <td style="white-space: nowrap; text-align: right">1875 ns</td>
    <td style="white-space: nowrap; text-align: right">3875 ns</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap;text-align: right">2.38 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">2.15 M</td>
    <td style="white-space: nowrap; text-align: right">1.1x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.37 M</td>
    <td style="white-space: nowrap; text-align: right">1.74x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.49 M</td>
    <td style="white-space: nowrap; text-align: right">4.85x</td>
  </tr>

</table>




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
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">2.34 M</td>
    <td style="white-space: nowrap; text-align: right">427.18 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1641.41%</td>
    <td style="white-space: nowrap; text-align: right">416 ns</td>
    <td style="white-space: nowrap; text-align: right">541 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">2.10 M</td>
    <td style="white-space: nowrap; text-align: right">476.31 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1242.41%</td>
    <td style="white-space: nowrap; text-align: right">458 ns</td>
    <td style="white-space: nowrap; text-align: right">584 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.36 M</td>
    <td style="white-space: nowrap; text-align: right">733.29 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1058.80%</td>
    <td style="white-space: nowrap; text-align: right">708 ns</td>
    <td style="white-space: nowrap; text-align: right">834 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.35 M</td>
    <td style="white-space: nowrap; text-align: right">2851.98 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;95.31%</td>
    <td style="white-space: nowrap; text-align: right">2708 ns</td>
    <td style="white-space: nowrap; text-align: right">6084 ns</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap;text-align: right">2.34 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">2.10 M</td>
    <td style="white-space: nowrap; text-align: right">1.11x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.36 M</td>
    <td style="white-space: nowrap; text-align: right">1.72x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.35 M</td>
    <td style="white-space: nowrap; text-align: right">6.68x</td>
  </tr>

</table>




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
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">2.22 M</td>
    <td style="white-space: nowrap; text-align: right">451.36 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1789.54%</td>
    <td style="white-space: nowrap; text-align: right">417 ns</td>
    <td style="white-space: nowrap; text-align: right">542 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">2.01 M</td>
    <td style="white-space: nowrap; text-align: right">497.16 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1698.97%</td>
    <td style="white-space: nowrap; text-align: right">459 ns</td>
    <td style="white-space: nowrap; text-align: right">625 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.80 M</td>
    <td style="white-space: nowrap; text-align: right">555.75 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1545.28%</td>
    <td style="white-space: nowrap; text-align: right">500 ns</td>
    <td style="white-space: nowrap; text-align: right">667 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.61 M</td>
    <td style="white-space: nowrap; text-align: right">1632.85 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;205.11%</td>
    <td style="white-space: nowrap; text-align: right">1459 ns</td>
    <td style="white-space: nowrap; text-align: right">2875 ns</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap;text-align: right">2.22 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">2.01 M</td>
    <td style="white-space: nowrap; text-align: right">1.1x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.80 M</td>
    <td style="white-space: nowrap; text-align: right">1.23x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.61 M</td>
    <td style="white-space: nowrap; text-align: right">3.62x</td>
  </tr>

</table>




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
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">228.61</td>
    <td style="white-space: nowrap; text-align: right">4.37 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1.04%</td>
    <td style="white-space: nowrap; text-align: right">4.36 ms</td>
    <td style="white-space: nowrap; text-align: right">4.53 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">213.87</td>
    <td style="white-space: nowrap; text-align: right">4.68 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;5.25%</td>
    <td style="white-space: nowrap; text-align: right">4.54 ms</td>
    <td style="white-space: nowrap; text-align: right">5.18 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">123.77</td>
    <td style="white-space: nowrap; text-align: right">8.08 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;8.75%</td>
    <td style="white-space: nowrap; text-align: right">7.95 ms</td>
    <td style="white-space: nowrap; text-align: right">10.18 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">27.16</td>
    <td style="white-space: nowrap; text-align: right">36.82 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;22.12%</td>
    <td style="white-space: nowrap; text-align: right">41.19 ms</td>
    <td style="white-space: nowrap; text-align: right">42.98 ms</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap;text-align: right">228.61</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">213.87</td>
    <td style="white-space: nowrap; text-align: right">1.07x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">123.77</td>
    <td style="white-space: nowrap; text-align: right">1.85x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">27.16</td>
    <td style="white-space: nowrap; text-align: right">8.42x</td>
  </tr>

</table>