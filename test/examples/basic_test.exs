defmodule JsonXema.Examples.Basic do
  use ExUnit.Case, async: true

  setup do
    schema =
      ~s({
      "$id": "https://example.com/person.schema.json",
      "$schema": "http://json-schema.org/draft-07/schema#",
      "title": "Person",
      "type": "object",
      "properties": {
        "firstName": {
          "type": "string",
          "description": "The person's first name."
        },
        "lastName": {
          "type": "string",
          "description": "The person's last name."
        },
        "age": {
          "description":
            "Age in years which must be equal to or greater than zero.",
          "type": "integer",
          "minimum": 0
        }
      }
    })
      |> Jason.decode!()
      |> JsonXema.new()

    %{schema: schema}
  end

  test "valid data", %{schema: schema} do
    assert JsonXema.valid?(schema, %{
             "firstName" => "John",
             "lastName" => "Smith",
             "age" => 55
           })
  end

  test "invalid data", %{schema: schema} do
    refute JsonXema.valid?(schema, %{
             "firstName" => "John",
             "lastName" => "Smith",
             "age" => -55
           })
  end
end
