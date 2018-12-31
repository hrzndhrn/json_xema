# JsonXema
[![Build Status](https://travis-ci.org/hrzndhrn/json_xema.svg?branch=master)](https://travis-ci.org/hrzndhrn/json_xema)
[![Coverage Status](https://coveralls.io/repos/github/hrzndhrn/json_xema/badge.svg?branch=master)](https://coveralls.io/github/hrzndhrn/json_xema?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/json_xema.svg)](https://hex.pm/packages/json_xema)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

JsonXema is a [JSON Schema](http://json-schema.org) validator with support
for draft 04, 06, and 07.

JsonXema based on elixir schema validator
[Xema](https://github.com/hrzndhrn/xema).

Xema is in early beta. If you try it and has an issue, report them.

## Installation

If [available in Hex](https://hex.pm), the package can be installed
like this:

First, add JsonXema to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:json_xema, "~> 0.1"}
  ]
end
```

Then, update your dependencies:

```shell
$ mix deps.get
```

## Usage

A JSON parser is required to create a schema from JSON. It is also possible to
create a schema directly from an elixir data structure. There are three functions available to validate data against a schema.
+ `JsonXema.valid?/2` gets a schema and any data and returns `true` for valid
  data and `false` otherwise.
+ `JsonXema.validate/2` gets a schema and any data and returns `:ok` for valid
  data and an error tuple otherwise.
+ `JsonXema.validate!/2` gets a schema and any data and returns `:ok` for valid
  data and raised an exception otherwise.

```elixir
iex> schema = """
...> {
...>   "type": "object",
...>   "properties": {
...>     "name": {
...>       "type": "string",
...>       "min_length": 3
...>     },
...>     "age": {
...>       "type": "integer",
...>       "minimum": 0
...>     }
...>   },
...>   "additionalProperties": false
...> }
...> """
...> |> Jason.decode!()
...> |> JsonXema.new()
...>
...> data = Jason.decode!("""
...>   {"name": "John", "age": 42}
...> """)
...> JsonXema.valid?(schema, data)
true
...> JsonXema.valid?(schema, %{"name" => "Peter", "age" => -55})
false
...> JsonXema.valid?(schema, %{"name" => "Peter", "old" => 55})
false
...> JsonXema.validate(schema, %{"name" => "Peter", "age" => -55})
{:error, %{properties: %{"age" => %{minimum: 0, value: -55}}}}
...> JsonXema.validate(schema, %{"name" => "Peter", "old" => 55})
{:error, %{properties: %{"old" => %{additionalProperties: false}}}}
```

## Unsupported semantic validation
For now, the keyword `format` do not support the following formats:
+ `idn-email` the I18N equivalent of `email`
+ `idn-hostname` I18N equivalent of `hostname`
+ `iri` the I18N equivalent of `uri`
+ `iri-reference` the I18N equivalent of `uri-reference`

## Tests

Tests in [test/json_xema](test/json_xema) are not organised as classic unit
tests but are related to JSON schema keywords or a specific feature.

The directory [test/suite](test/suite) contains tests for draft 04, 06, and 07
and are generated from the
[Json Schema Test Suite](https://github.com/json-schema-org/JSON-Schema-Test-Suite).

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
