defmodule Draft6.OneOfTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "oneOf" do
    setup do
      %{schema: ~s(
        {
          "oneOf": [
            {
              "type": "integer"
            },
            {
              "minimum": 2
            }
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "first oneOf valid", %{schema: schema} do
      data = 1
      assert valid?(schema, data)
    end

    test "second oneOf valid", %{schema: schema} do
      data = 2.5
      assert valid?(schema, data)
    end

    test "both oneOf valid", %{schema: schema} do
      data = 3
      refute valid?(schema, data)
    end

    test "neither oneOf valid", %{schema: schema} do
      data = 1.5
      refute valid?(schema, data)
    end
  end

  describe "oneOf with base schema" do
    setup do
      %{schema: ~s(
        {
          "oneOf": [
            {
              "minLength": 2
            },
            {
              "maxLength": 4
            }
          ],
          "type": "string"
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "mismatch base schema", %{schema: schema} do
      data = 3
      refute valid?(schema, data)
    end

    test "one oneOf valid", %{schema: schema} do
      data = "foobar"
      assert valid?(schema, data)
    end

    test "both oneOf valid", %{schema: schema} do
      data = "foo"
      refute valid?(schema, data)
    end
  end

  describe "oneOf with boolean schemas, all true" do
    setup do
      %{schema: ~s(
        {
          "oneOf": [
            true,
            true,
            true
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "any value is invalid", %{schema: schema} do
      data = "foo"
      refute valid?(schema, data)
    end
  end

  describe "oneOf with boolean schemas, one true" do
    setup do
      %{schema: ~s(
        {
          "oneOf": [
            true,
            false,
            false
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "any value is valid", %{schema: schema} do
      data = "foo"
      assert valid?(schema, data)
    end
  end

  describe "oneOf with boolean schemas, more than one true" do
    setup do
      %{schema: ~s(
        {
          "oneOf": [
            true,
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

  describe "oneOf with boolean schemas, all false" do
    setup do
      %{schema: ~s(
        {
          "oneOf": [
            false,
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

  describe "oneOf complex types" do
    setup do
      %{schema: ~s(
        {
          "oneOf": [
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

    test "first oneOf valid (complex)", %{schema: schema} do
      data = %{"bar" => 2}
      assert valid?(schema, data)
    end

    test "second oneOf valid (complex)", %{schema: schema} do
      data = %{"foo" => "baz"}
      assert valid?(schema, data)
    end

    test "both oneOf valid (complex)", %{schema: schema} do
      data = %{"bar" => 2, "foo" => "baz"}
      refute valid?(schema, data)
    end

    test "neither oneOf valid (complex)", %{schema: schema} do
      data = %{"bar" => "quux", "foo" => 2}
      refute valid?(schema, data)
    end
  end
end
