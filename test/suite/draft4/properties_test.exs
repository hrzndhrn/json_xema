defmodule Draft4.PropertiesTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "object properties validation" do
    setup do
      %{schema: ~s(
        {
          "properties": {
            "bar": {
              "type": "string"
            },
            "foo": {
              "type": "integer"
            }
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "both properties present and valid is valid", %{schema: schema} do
      data = %{"bar" => "baz", "foo" => 1}
      assert valid?(schema, data)
    end

    test "one property invalid is invalid", %{schema: schema} do
      data = %{"bar" => %{}, "foo" => 1}
      refute valid?(schema, data)
    end

    test "both properties invalid is invalid", %{schema: schema} do
      data = %{"bar" => %{}, "foo" => []}
      refute valid?(schema, data)
    end

    test "doesn't invalidate other properties", %{schema: schema} do
      data = %{"quux" => []}
      assert valid?(schema, data)
    end

    test "ignores arrays", %{schema: schema} do
      data = []
      assert valid?(schema, data)
    end

    test "ignores other non-objects", %{schema: schema} do
      data = 12
      assert valid?(schema, data)
    end
  end

  describe "properties, patternProperties, additionalProperties interaction" do
    setup do
      %{schema: ~s(
        {
          "additionalProperties": {
            "type": "integer"
          },
          "patternProperties": {
            "f.o": {
              "minItems": 2
            }
          },
          "properties": {
            "bar": {
              "type": "array"
            },
            "foo": {
              "maxItems": 3,
              "type": "array"
            }
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "property validates property", %{schema: schema} do
      data = %{"foo" => [1, 2]}
      assert valid?(schema, data)
    end

    test "property invalidates property", %{schema: schema} do
      data = %{"foo" => [1, 2, 3, 4]}
      refute valid?(schema, data)
    end

    test "patternProperty invalidates property", %{schema: schema} do
      data = %{"foo" => []}
      refute valid?(schema, data)
    end

    test "patternProperty validates nonproperty", %{schema: schema} do
      data = %{"fxo" => [1, 2]}
      assert valid?(schema, data)
    end

    test "patternProperty invalidates nonproperty", %{schema: schema} do
      data = %{"fxo" => []}
      refute valid?(schema, data)
    end

    test "additionalProperty ignores property", %{schema: schema} do
      data = %{"bar" => []}
      assert valid?(schema, data)
    end

    test "additionalProperty validates others", %{schema: schema} do
      data = %{"quux" => 3}
      assert valid?(schema, data)
    end

    test "additionalProperty invalidates others", %{schema: schema} do
      data = %{"quux" => "foo"}
      refute valid?(schema, data)
    end
  end
end
