defmodule Draft6.DependenciesTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "dependencies" do
    setup do
      %{schema: ~s(
        {
          "dependencies": {
            "bar": [
              "foo"
            ]
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "neither", %{schema: schema} do
      data = %{}
      assert valid?(schema, data)
    end

    test "nondependant", %{schema: schema} do
      data = %{"foo" => 1}
      assert valid?(schema, data)
    end

    test "with dependency", %{schema: schema} do
      data = %{"bar" => 2, "foo" => 1}
      assert valid?(schema, data)
    end

    test "missing dependency", %{schema: schema} do
      data = %{"bar" => 2}
      refute valid?(schema, data)
    end

    test "ignores arrays", %{schema: schema} do
      data = ["bar"]
      assert valid?(schema, data)
    end

    test "ignores strings", %{schema: schema} do
      data = "foobar"
      assert valid?(schema, data)
    end

    test "ignores other non-objects", %{schema: schema} do
      data = 12
      assert valid?(schema, data)
    end
  end

  describe "dependencies with empty array" do
    setup do
      %{schema: ~s(
        {
          "dependencies": {
            "bar": []
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "empty object", %{schema: schema} do
      data = %{}
      assert valid?(schema, data)
    end

    test "object with one property", %{schema: schema} do
      data = %{"bar" => 2}
      assert valid?(schema, data)
    end
  end

  describe "multiple dependencies" do
    setup do
      %{schema: ~s(
        {
          "dependencies": {
            "quux": [
              "foo",
              "bar"
            ]
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "neither", %{schema: schema} do
      data = %{}
      assert valid?(schema, data)
    end

    test "nondependants", %{schema: schema} do
      data = %{"bar" => 2, "foo" => 1}
      assert valid?(schema, data)
    end

    test "with dependencies", %{schema: schema} do
      data = %{"bar" => 2, "foo" => 1, "quux" => 3}
      assert valid?(schema, data)
    end

    test "missing dependency", %{schema: schema} do
      data = %{"foo" => 1, "quux" => 2}
      refute valid?(schema, data)
    end

    test "missing other dependency", %{schema: schema} do
      data = %{"bar" => 1, "quux" => 2}
      refute valid?(schema, data)
    end

    test "missing both dependencies", %{schema: schema} do
      data = %{"quux" => 1}
      refute valid?(schema, data)
    end
  end

  describe "multiple dependencies subschema" do
    setup do
      %{schema: ~s(
        {
          "dependencies": {
            "bar": {
              "properties": {
                "bar": {
                  "type": "integer"
                },
                "foo": {
                  "type": "integer"
                }
              }
            }
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid", %{schema: schema} do
      data = %{"bar" => 2, "foo" => 1}
      assert valid?(schema, data)
    end

    test "no dependency", %{schema: schema} do
      data = %{"foo" => "quux"}
      assert valid?(schema, data)
    end

    test "wrong type", %{schema: schema} do
      data = %{"bar" => 2, "foo" => "quux"}
      refute valid?(schema, data)
    end

    test "wrong type other", %{schema: schema} do
      data = %{"bar" => "quux", "foo" => 2}
      refute valid?(schema, data)
    end

    test "wrong type both", %{schema: schema} do
      data = %{"bar" => "quux", "foo" => "quux"}
      refute valid?(schema, data)
    end
  end

  describe "dependencies with boolean subschemas" do
    setup do
      %{schema: ~s(
        {
          "dependencies": {
            "bar": false,
            "foo": true
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "object with property having schema true is valid", %{schema: schema} do
      data = %{"foo" => 1}
      assert valid?(schema, data)
    end

    test "object with property having schema false is invalid", %{
      schema: schema
    } do
      data = %{"bar" => 2}
      refute valid?(schema, data)
    end

    test "object with both properties is invalid", %{schema: schema} do
      data = %{"bar" => 2, "foo" => 1}
      refute valid?(schema, data)
    end

    test "empty object is valid", %{schema: schema} do
      data = %{}
      assert valid?(schema, data)
    end
  end
end
