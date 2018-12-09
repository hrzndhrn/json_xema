defmodule Draft6.ItemsTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "a schema given for items" do
    setup do
      %{schema: ~s(
        {
          "items": {
            "type": "integer"
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid items", %{schema: schema} do
      data = [1, 2, 3]
      assert valid?(schema, data)
    end

    test "wrong type of items", %{schema: schema} do
      data = [1, "x"]
      refute valid?(schema, data)
    end

    test "ignores non-arrays", %{schema: schema} do
      data = %{"foo" => "bar"}
      assert valid?(schema, data)
    end

    test "JavaScript pseudo-array is valid", %{schema: schema} do
      data = %{"0" => "invalid", "length" => 1}
      assert valid?(schema, data)
    end
  end

  describe "an array of schemas for items" do
    setup do
      %{schema: ~s(
        {
          "items": [
            {
              "type": "integer"
            },
            {
              "type": "string"
            }
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "correct types", %{schema: schema} do
      data = [1, "foo"]
      assert valid?(schema, data)
    end

    test "wrong types", %{schema: schema} do
      data = ["foo", 1]
      refute valid?(schema, data)
    end

    test "incomplete array of items", %{schema: schema} do
      data = [1]
      assert valid?(schema, data)
    end

    test "array with additional items", %{schema: schema} do
      data = [1, "foo", true]
      assert valid?(schema, data)
    end

    test "empty array", %{schema: schema} do
      data = []
      assert valid?(schema, data)
    end

    test "JavaScript pseudo-array is valid", %{schema: schema} do
      data = %{"0" => "invalid", "1" => "valid", "length" => 2}
      assert valid?(schema, data)
    end
  end

  describe "items with boolean schema (true)" do
    setup do
      %{schema: ~s(
        {
          "items": true
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "any array is valid", %{schema: schema} do
      data = [1, "foo", true]
      assert valid?(schema, data)
    end

    test "empty array is valid", %{schema: schema} do
      data = []
      assert valid?(schema, data)
    end
  end

  describe "items with boolean schema (false)" do
    setup do
      %{schema: ~s(
        {
          "items": false
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "any non-empty array is invalid", %{schema: schema} do
      data = [1, "foo", true]
      refute valid?(schema, data)
    end

    test "empty array is valid", %{schema: schema} do
      data = []
      assert valid?(schema, data)
    end
  end

  describe "items with boolean schemas" do
    setup do
      %{schema: ~s(
        {
          "items": [
            true,
            false
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "array with one item is valid", %{schema: schema} do
      data = [1]
      assert valid?(schema, data)
    end

    test "array with two items is invalid", %{schema: schema} do
      data = [1, "foo"]
      refute valid?(schema, data)
    end

    test "empty array is valid", %{schema: schema} do
      data = []
      assert valid?(schema, data)
    end
  end
end
