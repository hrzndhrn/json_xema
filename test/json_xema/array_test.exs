defmodule JsonXema.ArrayTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2, validate: 2]

  alias JsonXema.ValidationError

  describe "'list' schema" do
    setup do
      %{schema: ~s({"type" : "array"}) |> Jason.decode!() |> JsonXema.new()}
    end

    test "validate/2 with an empty list", %{schema: schema} do
      assert validate(schema, []) == :ok
    end

    test "validate/2 with an list of different types", %{schema: schema} do
      assert validate(schema, [1, "bla", 3.4]) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, "not an array")
      assert error == %ValidationError{reason: %{type: "array", value: "not an array"}}
      assert Exception.message(error) == ~s|Expected "array", got "not an array".|
    end

    test "valid?/2 with a valid value", %{schema: schema} do
      assert valid?(schema, [1])
    end

    test "valid?/2 with an invalid value", %{schema: schema} do
      refute valid?(schema, 42)
    end
  end

  describe "'list' schema with size" do
    setup do
      %{schema: ~s({
        "type" : "array",
        "minItems" : 2,
        "maxItems" : 3
      }) |> Jason.decode!() |> JsonXema.new()}
    end

    test "validate/2 with too short list", %{schema: schema} do
      assert {:error, error} = validate(schema, [1])
      assert error == %ValidationError{reason: %{value: [1], minItems: 2}}
      assert Exception.message(error) == ~s|Expected at least 2 items, got [1].|
    end

    test "validate/2 with proper list", %{schema: schema} do
      assert validate(schema, [1, 2]) == :ok
    end

    test "validate/2 with to long list", %{schema: schema} do
      assert {:error, error} = validate(schema, [1, 2, 3, 4])
      assert error == %ValidationError{reason: %{value: [1, 2, 3, 4], maxItems: 3}}
      assert Exception.message(error) == ~s|Expected at most 3 items, got [1, 2, 3, 4].|
    end
  end

  describe "'list' schema with typed items" do
    setup do
      %{
        integers: ~s({
          "type" : "array",
          "items" : {
            "type" : "integer"
          }
        }) |> Jason.decode!() |> JsonXema.new(),
        strings: ~s({
          "type" : "array",
          "items" : {
            "type" : "string"
          }
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 integers with empty list", %{integers: schema} do
      assert validate(schema, []) == :ok
    end

    test "validate/2 integers with list of integers", %{integers: schema} do
      assert validate(schema, [1, 2]) == :ok
    end

    test "validate/2 integers with invalid list", %{integers: schema} do
      assert {:error, error} = validate(schema, [1, 2, "foo"])

      assert error == %ValidationError{
               reason: %{
                 items: %{2 => %{type: "integer", value: "foo"}}
               }
             }

      assert Exception.message(error) == ~s|Expected "integer", got "foo", at [2].|
    end

    test "validate/2 strings with empty list", %{strings: schema} do
      assert validate(schema, []) == :ok
    end

    test "validate/2 strings with list of string", %{strings: schema} do
      assert validate(schema, ["foo"]) == :ok
    end

    test "validate/2 strings with invalid list", %{strings: schema} do
      assert {:error, error} = validate(schema, [1, 2, "foo"])

      assert error == %ValidationError{
               reason: %{
                 items: %{0 => %{type: "string", value: 1}, 1 => %{type: "string", value: 2}}
               }
             }

      assert Exception.message(error) == """
             Expected "string", got 1, at [0].
             Expected "string", got 2, at [1].\
             """
    end
  end

  describe "'list' schema with unique items" do
    setup do
      %{schema: ~s({
        "type" : "array",
        "uniqueItems" : true
      }) |> Jason.decode!() |> JsonXema.new()}
    end

    test "validate/2 with list of unique items", %{schema: schema} do
      assert validate(schema, [1, 2, 3]) == :ok
    end

    test "validate/2 with list of not unique items", %{schema: schema} do
      assert {:error, error} = validate(schema, [1, 2, 3, 3, 4])
      assert error == %ValidationError{reason: %{value: [1, 2, 3, 3, 4], uniqueItems: true}}
      assert Exception.message(error) == ~s|Expected unique items, got [1, 2, 3, 3, 4].|
    end
  end

  describe "'list' schema with tuple validation" do
    setup do
      %{
        schema: ~s({
          "type" : "array",
          "items" : [
            {
              "type" : "string",
              "minLength" : 3
            },
            {
              "type" : "number",
              "minimum" : 10
            }
          ]
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with valid values", %{schema: schema} do
      assert validate(schema, ["foo", 42]) == :ok
    end

    test "validate/2 with invalid values", %{schema: schema} do
      assert {:error, error} = validate(schema, ["foo", "bar"])
      assert error == %ValidationError{reason: %{items: %{1 => %{type: "number", value: "bar"}}}}
      assert Exception.message(error) == ~s|Expected "number", got "bar", at [1].|

      assert {:error, error} = validate(schema, ["x", 33])
      assert error == %ValidationError{reason: %{items: %{0 => %{value: "x", minLength: 3}}}}
      assert Exception.message(error) == ~s|Expected minimum length of 3, got "x", at [0].|
    end

    test "validate/2 with invalid value and additional item", %{schema: schema} do
      assert {:error, error} = validate(schema, ["x", 33, 7])
      assert error == %ValidationError{reason: %{items: %{0 => %{value: "x", minLength: 3}}}}
      assert Exception.message(error) == ~s|Expected minimum length of 3, got "x", at [0].|
    end

    test "validate/2 with additional item", %{schema: schema} do
      assert validate(schema, ["foo", 42, "add"]) == :ok
    end

    test "validate/2 with missing item", %{schema: schema} do
      assert validate(schema, ["foo"]) == :ok
    end
  end

  describe "'list' schema with tuple validation without additional items" do
    setup do
      %{
        schema: ~s({
          "type" : "array",
          "additionalItems" : false,
          "items" : [
            {
              "type" : "string",
              "minLength" : 3
            },
            {
              "type" : "number",
              "minimum" : 10
            }
          ]
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with additional item", %{schema: schema} do
      assert {:error, error} = validate(schema, ["foo", 42, "add"])
      assert error == %ValidationError{reason: %{items: %{2 => %{additionalItems: false}}}}
      assert Exception.message(error) == ~s|Unexpected additional item, at [2].|
    end
  end

  describe "list schema with with specific additional items" do
    setup do
      %{
        schema: ~s({
          "type" : "array",
          "additionalItems" : {
            "type" : "string"
          },
          "items" : [
            {
              "type" : "number",
              "minimum" : 10
            }
          ]
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with valid additional item", %{schema: schema} do
      assert validate(schema, [11, "twelve", "thirteen"]) == :ok
    end

    test "validate/2 with invalid additional item", %{schema: schema} do
      assert {:error, error} = validate(schema, [11, "twelve", 13])
      assert error == %ValidationError{reason: %{items: %{2 => %{type: "string", value: 13}}}}
      assert Exception.message(error) == ~s|Expected "string", got 13, at [2].|
    end
  end

  describe "contains keyword validation" do
    setup do
      %{schema: ~s(
        {
          "contains": {
            "minimum": 5
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "array with item matching schema (5) is valid", %{schema: schema} do
      data = [3, 4, 5]
      assert validate(schema, data) == :ok
    end

    test "array without items matching schema is invalid", %{schema: schema} do
      data = [2, 3, 4]
      assert {:error, error} = validate(schema, data)

      assert error == %ValidationError{
               reason: %{
                 contains: [
                   {0, %{minimum: 5, value: 2}},
                   {1, %{minimum: 5, value: 3}},
                   {2, %{minimum: 5, value: 4}}
                 ],
                 value: [2, 3, 4]
               }
             }

      assert Exception.message(error) == """
             No items match contains.
               Value 2 is less than minimum value of 5, at [0].
               Value 3 is less than minimum value of 5, at [1].
               Value 4 is less than minimum value of 5, at [2].\
             """
    end
  end
end
