# Usage

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
{:error, %JsonXema.ValidationError{
  reason: %{properties: %{"age" => %{minimum: 0, value: -55}}}}}
...> JsonXema.validate(schema, %{"name" => "Peter", "old" => 55})
{:error, %JsonXema.ValidationError{
  reason: %{properties: %{"old" => %{additionalProperties: false}}}}}
```
