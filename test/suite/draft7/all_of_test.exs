defmodule Draft7.AllOfTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "allOf" do
    setup do
      %{schema: ~s(
        {
          "allOf": [
            {
              "properties": {
                "bar": {
                  "type": "integer"
                }
              },
              "required": [
                "bar"
              ]
            },
            {
              "properties": {
                "foo": {
                  "type": "string"
                }
              },
              "required": [
                "foo"
              ]
            }
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "allOf", %{schema: schema} do
      data = %{"bar" => 2, "foo" => "baz"}
      assert valid?(schema, data)
    end

    test "mismatch second", %{schema: schema} do
      data = %{"foo" => "baz"}
      refute valid?(schema, data)
    end

    test "mismatch first", %{schema: schema} do
      data = %{"bar" => 2}
      refute valid?(schema, data)
    end

    test "wrong type", %{schema: schema} do
      data = %{"bar" => "quux", "foo" => "baz"}
      refute valid?(schema, data)
    end
  end

  describe "allOf with base schema" do
    setup do
      %{schema: ~s(
        {
          "allOf": [
            {
              "properties": {
                "foo": {
                  "type": "string"
                }
              },
              "required": [
                "foo"
              ]
            },
            {
              "properties": {
                "baz": {
                  "type": "null"
                }
              },
              "required": [
                "baz"
              ]
            }
          ],
          "properties": {
            "bar": {
              "type": "integer"
            }
          },
          "required": [
            "bar"
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid", %{schema: schema} do
      data = %{"bar" => 2, "baz" => nil, "foo" => "quux"}
      assert valid?(schema, data)
    end

    test "mismatch base schema", %{schema: schema} do
      data = %{"baz" => nil, "foo" => "quux"}
      refute valid?(schema, data)
    end

    test "mismatch first allOf", %{schema: schema} do
      data = %{"bar" => 2, "baz" => nil}
      refute valid?(schema, data)
    end

    test "mismatch second allOf", %{schema: schema} do
      data = %{"bar" => 2, "foo" => "quux"}
      refute valid?(schema, data)
    end

    test "mismatch both", %{schema: schema} do
      data = %{"bar" => 2}
      refute valid?(schema, data)
    end
  end

  describe "allOf simple types" do
    setup do
      %{schema: ~s(
        {
          "allOf": [
            {
              "maximum": 30
            },
            {
              "minimum": 20
            }
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid", %{schema: schema} do
      data = 25
      assert valid?(schema, data)
    end

    test "mismatch one", %{schema: schema} do
      data = 35
      refute valid?(schema, data)
    end
  end

  describe "allOf with boolean schemas, all true" do
    setup do
      %{schema: ~s(
        {
          "allOf": [
            true,
            true
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "any value is valid", %{schema: schema} do
      data = "foo"
      assert valid?(schema, data)
    end
  end

  describe "allOf with boolean schemas, some false" do
    setup do
      %{schema: ~s(
        {
          "allOf": [
            true,
            false
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "any value is invalid", %{schema: schema} do
      data = "foo"
      refute valid?(schema, data)
    end
  end

  describe "allOf with boolean schemas, all false" do
    setup do
      %{schema: ~s(
        {
          "allOf": [
            false,
            false
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "any value is invalid", %{schema: schema} do
      data = "foo"
      refute valid?(schema, data)
    end
  end
end
