# JsonXema
[![Hex.pm: version](https://img.shields.io/hexpm/v/json_xema.svg?style=flat-square)](https://hex.pm/packages/json_xema)
[![GitHub: CI status](https://img.shields.io/github/actions/workflow/status/hrzndhrn/json_xema/ci.yml?branch=main&style=flat-square)](https://github.com/hrzndhrn/json_xema/actions)
[![Coveralls: coverage](https://img.shields.io/coveralls/github/hrzndhrn/json_xema?style=flat-square)](https://coveralls.io/github/hrzndhrn/json_xema)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://github.com/hrzndhrn/json_xema/blob/main/LICENSE.md)

JsonXema is a [JSON Schema](http://json-schema.org) validator with support
for draft 04, 06, and 07.

JsonXema based on elixir schema validator
[Xema](https://github.com/hrzndhrn/xema).

JsonXema is in early beta. If you try it and has an issue, report them.

## Installation

If [available in Hex](https://hex.pm), the package can be installed
like this:

First, add JsonXema to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:json_xema, "~> 0.3"}
  ]
end
```

Then, update your dependencies:

```shell
$ mix deps.get
```

## Docs

The docs contains a [Usage](https://hexdocs.pm/json_xema/usage.html) page with a
short and compact description to use `JsonXema`.

A loader must be configured to support remote schemas. The documentation
contains a description on page
[Configure a loader](https://hexdocs.pm/json_xema/loader.html).

Documentation can be generated with
[ExDoc](https://github.com/elixir-lang/ex_doc) by running `mix docs`. The
generated docs can be found at
[https://hexdocs.pm/json_xema](https://hexdocs.pm/json_xema).

## Tests

Tests in [test/json_xema](test/json_xema) are not organised as classic unit
tests but are related to JSON schema keywords or a specific feature.

The directory [test/suite](test/suite) contains tests for draft 04, 06, and 07
and are generated from the
[Json Schema Test Suite](https://github.com/json-schema-org/JSON-Schema-Test-Suite).

## Benchmark

A benchmark test can be started with `mix bench`. More about the benchmark can
be found at [bench](bench).

## References

The home of JSON Schema: http://json-schema.org/

Specification:

* Draft-04
  * [JSON Schema core](http://json-schema.org/draft-04/json-schema-core.html)
defines the basic foundation of JSON Schema
  * [JSON Schema Validation](http://json-schema.org/draft-04/json-schema-validation.html)
defines the validation keywords of JSON Schema
* Draft-06
  * [JSON Schema core](http://json-schema.org/draft-06/json-schema-core.html)
  * [JSON Schema Validation](http://json-schema.org/draft-06/json-schema-validation.html)
  * [JSON Schema Release Notes](http://json-schema.org/draft-06/json-schema-release-notes.html)
contains informations to migrate schemas.
* Draft-07
  * [JSON Schema core](http://json-schema.org/draft-07/json-schema-core.html)
  * [JSON Schema Validation](http://json-schema.org/draft-07/json-schema-validation.html)
  * [JSON Schema Release Notes](http://json-schema.org/draft-07/json-schema-release-notes.html)


[Understanding JSON Schema](https://spacetelescope.github.io/understanding-json-schema/index.html)
a great tutorial for JSON Schema authors.
