Benchmark

Benchmark run from 2026-02-21 16:20:56.153466Z UTC

## System

Benchmark suite executing on the following system:

<table style="width: 1%">
  <tr>
    <th style="width: 1%; white-space: nowrap">Operating System</th>
    <td>macOS</td>
  </tr><tr>
    <th style="white-space: nowrap">CPU Information</th>
    <td style="white-space: nowrap">Apple M1</td>
  </tr><tr>
    <th style="white-space: nowrap">Number of Available Cores</th>
    <td style="white-space: nowrap">8</td>
  </tr><tr>
    <th style="white-space: nowrap">Available Memory</th>
    <td style="white-space: nowrap">16 GB</td>
  </tr><tr>
    <th style="white-space: nowrap">Elixir Version</th>
    <td style="white-space: nowrap">1.18.4</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">28.0</td>
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
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">441.60 K</td>
    <td style="white-space: nowrap; text-align: right">2.26 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2074.03%</td>
    <td style="white-space: nowrap; text-align: right">2.04 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">2.25 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">439.06 K</td>
    <td style="white-space: nowrap; text-align: right">2.28 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;918.25%</td>
    <td style="white-space: nowrap; text-align: right">2 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">2.38 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">178.92 K</td>
    <td style="white-space: nowrap; text-align: right">5.59 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;421.77%</td>
    <td style="white-space: nowrap; text-align: right">4 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">9.75 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">80.69 K</td>
    <td style="white-space: nowrap; text-align: right">12.39 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;223.08%</td>
    <td style="white-space: nowrap; text-align: right">9 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">196.72 &micro;s</td>
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
    <td style="white-space: nowrap;text-align: right">441.60 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">439.06 K</td>
    <td style="white-space: nowrap; text-align: right">1.01x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">178.92 K</td>
    <td style="white-space: nowrap; text-align: right">2.47x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">80.69 K</td>
    <td style="white-space: nowrap; text-align: right">5.47x</td>
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
    <td style="white-space: nowrap; text-align: right">2.13 M</td>
    <td style="white-space: nowrap; text-align: right">468.72 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2002.59%</td>
    <td style="white-space: nowrap; text-align: right">417 ns</td>
    <td style="white-space: nowrap; text-align: right">542 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.96 M</td>
    <td style="white-space: nowrap; text-align: right">509.74 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1359.67%</td>
    <td style="white-space: nowrap; text-align: right">459 ns</td>
    <td style="white-space: nowrap; text-align: right">625 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.44 M</td>
    <td style="white-space: nowrap; text-align: right">692.58 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1296.65%</td>
    <td style="white-space: nowrap; text-align: right">625 ns</td>
    <td style="white-space: nowrap; text-align: right">875 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.53 M</td>
    <td style="white-space: nowrap; text-align: right">1880.36 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;137.09%</td>
    <td style="white-space: nowrap; text-align: right">1750 ns</td>
    <td style="white-space: nowrap; text-align: right">3459 ns</td>
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
    <td style="white-space: nowrap;text-align: right">2.13 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.96 M</td>
    <td style="white-space: nowrap; text-align: right">1.09x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.44 M</td>
    <td style="white-space: nowrap; text-align: right">1.48x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.53 M</td>
    <td style="white-space: nowrap; text-align: right">4.01x</td>
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
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">35.99 K</td>
    <td style="white-space: nowrap; text-align: right">27.79 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;205.59%</td>
    <td style="white-space: nowrap; text-align: right">26.71 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">38.93 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">30.77 K</td>
    <td style="white-space: nowrap; text-align: right">32.50 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1294.58%</td>
    <td style="white-space: nowrap; text-align: right">27.67 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">83.21 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">8.44 K</td>
    <td style="white-space: nowrap; text-align: right">118.46 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;13.52%</td>
    <td style="white-space: nowrap; text-align: right">115.95 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">160.27 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.76 K</td>
    <td style="white-space: nowrap; text-align: right">1316.72 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;4.98%</td>
    <td style="white-space: nowrap; text-align: right">1294.35 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">1597.34 &micro;s</td>
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
    <td style="white-space: nowrap;text-align: right">35.99 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">30.77 K</td>
    <td style="white-space: nowrap; text-align: right">1.17x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">8.44 K</td>
    <td style="white-space: nowrap; text-align: right">4.26x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.76 K</td>
    <td style="white-space: nowrap; text-align: right">47.39x</td>
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
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.61 M</td>
    <td style="white-space: nowrap; text-align: right">620.06 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;3852.22%</td>
    <td style="white-space: nowrap; text-align: right">542 ns</td>
    <td style="white-space: nowrap; text-align: right">750 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">1.49 M</td>
    <td style="white-space: nowrap; text-align: right">671.14 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;3710.39%</td>
    <td style="white-space: nowrap; text-align: right">500 ns</td>
    <td style="white-space: nowrap; text-align: right">1041 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.12 M</td>
    <td style="white-space: nowrap; text-align: right">889.76 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2873.38%</td>
    <td style="white-space: nowrap; text-align: right">833 ns</td>
    <td style="white-space: nowrap; text-align: right">1042 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.57 M</td>
    <td style="white-space: nowrap; text-align: right">1750.75 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;319.32%</td>
    <td style="white-space: nowrap; text-align: right">1542 ns</td>
    <td style="white-space: nowrap; text-align: right">3417 ns</td>
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
    <td style="white-space: nowrap;text-align: right">1.61 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">1.49 M</td>
    <td style="white-space: nowrap; text-align: right">1.08x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.12 M</td>
    <td style="white-space: nowrap; text-align: right">1.43x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.57 M</td>
    <td style="white-space: nowrap; text-align: right">2.82x</td>
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
    <td style="white-space: nowrap; text-align: right">1.25 M</td>
    <td style="white-space: nowrap; text-align: right">800.93 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1145.38%</td>
    <td style="white-space: nowrap; text-align: right">708 ns</td>
    <td style="white-space: nowrap; text-align: right">1375 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.20 M</td>
    <td style="white-space: nowrap; text-align: right">831.09 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1196.57%</td>
    <td style="white-space: nowrap; text-align: right">750 ns</td>
    <td style="white-space: nowrap; text-align: right">959 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">0.0256 M</td>
    <td style="white-space: nowrap; text-align: right">39031.51 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;255.30%</td>
    <td style="white-space: nowrap; text-align: right">36250 ns</td>
    <td style="white-space: nowrap; text-align: right">56816.83 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.00023 M</td>
    <td style="white-space: nowrap; text-align: right">4385566 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;0.44%</td>
    <td style="white-space: nowrap; text-align: right">4381187.50 ns</td>
    <td style="white-space: nowrap; text-align: right">4442013.11 ns</td>
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
    <td style="white-space: nowrap;text-align: right">1.25 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.20 M</td>
    <td style="white-space: nowrap; text-align: right">1.04x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">0.0256 M</td>
    <td style="white-space: nowrap; text-align: right">48.73x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.00023 M</td>
    <td style="white-space: nowrap; text-align: right">5475.62x</td>
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
    <td style="white-space: nowrap; text-align: right">1.61 M</td>
    <td style="white-space: nowrap; text-align: right">0.62 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;6764.61%</td>
    <td style="white-space: nowrap; text-align: right">0.54 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">0.67 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.53 M</td>
    <td style="white-space: nowrap; text-align: right">0.65 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2420.40%</td>
    <td style="white-space: nowrap; text-align: right">0.58 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">0.75 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">0.68 M</td>
    <td style="white-space: nowrap; text-align: right">1.48 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;287.20%</td>
    <td style="white-space: nowrap; text-align: right">1.46 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">1.67 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.30 M</td>
    <td style="white-space: nowrap; text-align: right">3.35 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;132.39%</td>
    <td style="white-space: nowrap; text-align: right">2.88 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">17.58 &micro;s</td>
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
    <td style="white-space: nowrap;text-align: right">1.61 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.53 M</td>
    <td style="white-space: nowrap; text-align: right">1.05x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">0.68 M</td>
    <td style="white-space: nowrap; text-align: right">2.38x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.30 M</td>
    <td style="white-space: nowrap; text-align: right">5.4x</td>
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
    <td style="white-space: nowrap; text-align: right">2.00 M</td>
    <td style="white-space: nowrap; text-align: right">499.56 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1419.58%</td>
    <td style="white-space: nowrap; text-align: right">458 ns</td>
    <td style="white-space: nowrap; text-align: right">584 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.74 M</td>
    <td style="white-space: nowrap; text-align: right">574.13 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2364.67%</td>
    <td style="white-space: nowrap; text-align: right">541 ns</td>
    <td style="white-space: nowrap; text-align: right">708 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.26 M</td>
    <td style="white-space: nowrap; text-align: right">795.86 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;842.63%</td>
    <td style="white-space: nowrap; text-align: right">750 ns</td>
    <td style="white-space: nowrap; text-align: right">1000 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.41 M</td>
    <td style="white-space: nowrap; text-align: right">2433.22 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;130.93%</td>
    <td style="white-space: nowrap; text-align: right">2209 ns</td>
    <td style="white-space: nowrap; text-align: right">5292 ns</td>
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
    <td style="white-space: nowrap;text-align: right">2.00 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.74 M</td>
    <td style="white-space: nowrap; text-align: right">1.15x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.26 M</td>
    <td style="white-space: nowrap; text-align: right">1.59x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.41 M</td>
    <td style="white-space: nowrap; text-align: right">4.87x</td>
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
    <td style="white-space: nowrap; text-align: right">1.95 M</td>
    <td style="white-space: nowrap; text-align: right">513.66 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1479.36%</td>
    <td style="white-space: nowrap; text-align: right">459 ns</td>
    <td style="white-space: nowrap; text-align: right">625 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.82 M</td>
    <td style="white-space: nowrap; text-align: right">549.84 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;933.74%</td>
    <td style="white-space: nowrap; text-align: right">541 ns</td>
    <td style="white-space: nowrap; text-align: right">667 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.25 M</td>
    <td style="white-space: nowrap; text-align: right">798.81 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;799.71%</td>
    <td style="white-space: nowrap; text-align: right">750 ns</td>
    <td style="white-space: nowrap; text-align: right">959 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.31 M</td>
    <td style="white-space: nowrap; text-align: right">3213.72 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;58.53%</td>
    <td style="white-space: nowrap; text-align: right">3084 ns</td>
    <td style="white-space: nowrap; text-align: right">4542 ns</td>
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
    <td style="white-space: nowrap;text-align: right">1.95 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.82 M</td>
    <td style="white-space: nowrap; text-align: right">1.07x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.25 M</td>
    <td style="white-space: nowrap; text-align: right">1.56x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.31 M</td>
    <td style="white-space: nowrap; text-align: right">6.26x</td>
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
    <td style="white-space: nowrap; text-align: right">1.89 M</td>
    <td style="white-space: nowrap; text-align: right">528.81 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1862.02%</td>
    <td style="white-space: nowrap; text-align: right">500 ns</td>
    <td style="white-space: nowrap; text-align: right">625 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.75 M</td>
    <td style="white-space: nowrap; text-align: right">569.90 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1443.91%</td>
    <td style="white-space: nowrap; text-align: right">542 ns</td>
    <td style="white-space: nowrap; text-align: right">667 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.60 M</td>
    <td style="white-space: nowrap; text-align: right">625.58 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1793.77%</td>
    <td style="white-space: nowrap; text-align: right">583 ns</td>
    <td style="white-space: nowrap; text-align: right">792 ns</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.51 M</td>
    <td style="white-space: nowrap; text-align: right">1958.48 ns</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;1071.96%</td>
    <td style="white-space: nowrap; text-align: right">1750 ns</td>
    <td style="white-space: nowrap; text-align: right">3417 ns</td>
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
    <td style="white-space: nowrap;text-align: right">1.89 M</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST</td>
    <td style="white-space: nowrap; text-align: right">1.75 M</td>
    <td style="white-space: nowrap; text-align: right">1.08x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">1.60 M</td>
    <td style="white-space: nowrap; text-align: right">1.18x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">0.51 M</td>
    <td style="white-space: nowrap; text-align: right">3.7x</td>
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
    <td style="white-space: nowrap; text-align: right">227.77</td>
    <td style="white-space: nowrap; text-align: right">4.39 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;6.10%</td>
    <td style="white-space: nowrap; text-align: right">4.30 ms</td>
    <td style="white-space: nowrap; text-align: right">5.35 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">222.42</td>
    <td style="white-space: nowrap; text-align: right">4.50 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;21.49%</td>
    <td style="white-space: nowrap; text-align: right">4.24 ms</td>
    <td style="white-space: nowrap; text-align: right">7.59 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">61.49</td>
    <td style="white-space: nowrap; text-align: right">16.26 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;174.13%</td>
    <td style="white-space: nowrap; text-align: right">9.50 ms</td>
    <td style="white-space: nowrap; text-align: right">223.98 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">26.34</td>
    <td style="white-space: nowrap; text-align: right">37.96 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;18.41%</td>
    <td style="white-space: nowrap; text-align: right">43.01 ms</td>
    <td style="white-space: nowrap; text-align: right">44.07 ms</td>
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
    <td style="white-space: nowrap;text-align: right">227.77</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonschema_RUST-Performance Profile</td>
    <td style="white-space: nowrap; text-align: right">222.42</td>
    <td style="white-space: nowrap; text-align: right">1.02x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">JsonXema</td>
    <td style="white-space: nowrap; text-align: right">61.49</td>
    <td style="white-space: nowrap; text-align: right">3.7x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">ExJsonSchema</td>
    <td style="white-space: nowrap; text-align: right">26.34</td>
    <td style="white-space: nowrap; text-align: right">8.65x</td>
  </tr>

</table>