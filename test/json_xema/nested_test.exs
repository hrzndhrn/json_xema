defmodule Xema.NestedTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  describe "list of objects in one schema:" do
    setup do
      %{
        schema: JsonXema.new(~s(
            {
              "type": "object",
              "properties": {
                "id": {
                  "type": "number",
                  "minimum": 1
                },
                "items": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "properties": {
                      "num": {
                        "type": "number",
                        "minimum": 0
                      },
                      "desc": {
                        "type": "string"
                      }
                    }
                  }
                }
              }
            }
          ))
      }
    end

    test "validate/2 with valid data", %{schema: schema} do
      data = %{
        "id" => 5,
        "items" => [
          %{"num" => 1, "desc" => "foo"},
          %{"num" => 2, "desc" => "bar"}
        ]
      }

      assert validate(schema, data) == :ok
    end

    test "validate/2 with invalid data", %{schema: schema} do
      data = %{
        "id" => 5,
        "items" => [
          %{"num" => 1, "desc" => "foo"},
          %{"num" => -2, "desc" => "bar"}
        ]
      }

      error = {
        :error,
        %{
          properties: %{
            "items" => %{
              items: [
                {
                  1,
                  %{
                    properties: %{
                      "num" => %{value: -2, minimum: 0}
                    }
                  }
                }
              ]
            }
          }
        }
      }

      assert validate(schema, data) == error
    end
  end
end
