defmodule JsonXema.Examples.ArraysOfThings do
  use ExUnit.Case, async: true

  setup do
    schema =
      ~s({
        "$id": "https://example.com/arrays.schema.json",
        "$schema": "http://json-schema.org/draft-07/schema#",
        "description":
          "A representation of a person, company, organization, or place",
        "type": "object",
        "properties": {
          "fruits": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "vegetables": {
            "type": "array",
            "items": { "$ref": "#/definitions/veggie" }
          }
        },
        "definitions": {
          "veggie": {
            "type": "object",
            "required": [ "veggieName", "veggieLike" ],
            "properties": {
              "veggieName": {
                "type": "string",
                "description": "The name of the vegetable."
              },
              "veggieLike": {
                "type": "boolean",
                "description": "Do I like this vegetable?"
              }
            }
          }
        }
      })
      |> Jason.decode!()
      |> JsonXema.new()

    %{schema: schema}
  end

  test "valid data", %{schema: schema} do
    data = Jason.decode!(~s({
      "fruits": [ "apple", "orange", "pear" ],
      "vegetables": [
        {
          "veggieName": "potato",
          "veggieLike": true
        },
        {
          "veggieName": "broccoli",
          "veggieLike": false
        }
      ]
    }))

    assert JsonXema.valid?(schema, data)
  end

  test "invalid data", %{schema: schema} do
    data = Jason.decode!(~s({
      "fruits": [ "apple", "orange", "pear" ],
      "vegetables": [
        {
          "veggieName": "potato",
          "veggieLike": "true"
        },
        {
          "veggieName": "broccoli",
          "veggieLike": false
        }
      ]
    }))

    refute JsonXema.valid?(schema, data)
  end
end
