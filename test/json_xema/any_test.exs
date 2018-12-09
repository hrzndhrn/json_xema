defmodule JsonXema.AnyTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2, validate: 2]

  describe "'any' schema" do
    setup do
      %{schema: "{}" |> Jason.decode!() |> JsonXema.new()}
    end

    @tag :only
    test "valid?/2 with a string", %{schema: schema} do
      assert valid?(schema, "foo")
    end

    test "valid?/2 with a number", %{schema: schema} do
      assert valid?(schema, 42)
    end

    test "valid?/2 with nil", %{schema: schema} do
      assert valid?(schema, nil)
    end

    test "valid?/2 with a list", %{schema: schema} do
      assert valid?(schema, [1, 2, 3])
    end

    test "validate/2 with a string", %{schema: schema} do
      assert validate(schema, "foo") == :ok
    end

    test "validate/2 with a number", %{schema: schema} do
      assert validate(schema, 42) == :ok
    end

    test "validate/2 with nil", %{schema: schema} do
      assert validate(schema, nil) == :ok
    end

    test "validate/2 with a list", %{schema: schema} do
      assert validate(schema, [1, 2, 3]) == :ok
    end
  end

  describe "'any' schema with enum:" do
    setup do
      %{
        schema:
          ~s({"enum" : [1, 1.2, [1], "foo"]})
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a value from the enum", %{schema: schema} do
      assert validate(schema, 1) == :ok
      assert validate(schema, 1.2) == :ok
      assert validate(schema, "foo") == :ok
      assert validate(schema, [1]) == :ok
    end

    test "validate/2 with a value that is not in the enum", %{schema: schema} do
      expected = {:error, %{value: 2, enum: [1, 1.2, [1], "foo"]}}

      assert validate(schema, 2) == expected
    end

    test "valid?/2 with a valid value", %{schema: schema} do
      assert valid?(schema, 1)
    end

    test "valid?/2 with an invalid value", %{schema: schema} do
      refute valid?(schema, 5)
    end
  end

  describe "keyword not:" do
    setup do
      %{
        schema:
          ~s({"not" : {"type" : "integer"}})
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, "foo") == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, 1) == {:error, %{not: :ok, value: 1}}
    end
  end

  describe "nested keyword not:" do
    setup do
      %{
        schema: ~s(
            {
              "type": "object",
              "properties": {
                "foo": {
                  "not": {
                    "type": "string",
                    "minLength": 3
                  }
                }
              }
            }
        ) |> Jason.decode!() |> JsonXema.new()
      }
    end

    @tag :only
    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, %{"foo" => ""}) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, %{"foo" => "foo"}) ==
               {:error, %{properties: %{"foo" => %{not: :ok, value: "foo"}}}}
    end
  end

  describe "keyword allOf:" do
    setup do
      %{
        schema: ~s(
            {
              "allOf": [
                {"type": "integer"},
                {"type": "integer", "minimum": 0}
              ]
            }
        ) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 1) == :ok
    end

    test "validate/2 with an imvalid value", %{schema: schema} do
      assert validate(schema, -1) ==
               {:error, %{allOf: [%{minimum: 0, value: -1}], value: -1}}
    end
  end

  describe "keyword anyOf:" do
    setup do
      %{
        schema: ~s(
            {"anyOf": [
              {"type": "null"},
              {"type": "integer", "minimum": 1}
            ]}
        ) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 1) == :ok
      assert validate(schema, nil) == :ok
    end

    @tag :only
    test "validate/2 with an imvalid value", %{schema: schema} do
      assert validate(schema, "foo") ==
               {:error,
                %{
                  anyOf: [
                    %{type: "null", value: "foo"},
                    %{type: "integer", value: "foo"}
                  ],
                  value: "foo"
                }}
    end
  end

  describe "keyword one_of (multiple_of):" do
    setup do
      %{
        schema: ~s(
            {"oneOf": [
              {
                "type": "integer",
                "multipleOf": 3
              }, {
                "type": "integer",
                "multipleOf": 5
              }
            ]}
        ) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 9) == :ok
      assert validate(schema, 10) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, 15) == {:error, %{oneOf: [], value: 15}}

      assert validate(schema, 4) ==
               {:error,
                %{
                  oneOf: [
                    %{multipleOf: 5, value: 4},
                    %{multipleOf: 3, value: 4}
                  ],
                  value: 4
                }}
    end
  end

  describe "keyword one_of (multiple_of integer):" do
    setup do
      %{
        schema: ~s(
            {
              "type": "integer",
              "oneOf": [
                {"multipleOf": 3},
                {"multipleOf": 5}
              ]
            }
        ) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 9) == :ok
      assert validate(schema, 10) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, 15) == {:error, %{oneOf: [], value: 15}}

      assert validate(schema, 4) ==
               {:error,
                %{
                  oneOf: [
                    %{multipleOf: 5, value: 4},
                    %{multipleOf: 3, value: 4}
                  ],
                  value: 4
                }}
    end
  end
end
