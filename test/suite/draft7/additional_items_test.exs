defmodule Draft7.AdditionalItemsTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "additionalItems as schema" do
    setup do
      %{schema: ~s(
        {
          "additionalItems": {
            "type": "integer"
          },
          "items": [
            {}
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "additional items match schema", %{schema: schema} do
      data = [nil, 2, 3, 4]
      assert valid?(schema, data)
    end

    test "additional items do not match schema", %{schema: schema} do
      data = [nil, 2, 3, "foo"]
      refute valid?(schema, data)
    end
  end

  describe "items is schema, no additionalItems" do
    setup do
      %{schema: ~s(
        {
          "additionalItems": false,
          "items": {}
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "all items match schema", %{schema: schema} do
      data = [1, 2, 3, 4, 5]
      assert valid?(schema, data)
    end
  end

  describe "array of items with no additionalItems" do
    setup do
      %{schema: ~s(
        {
          "additionalItems": false,
          "items": [
            {},
            {},
            {}
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "fewer number of items present", %{schema: schema} do
      data = [1, 2]
      assert valid?(schema, data)
    end

    test "equal number of items present", %{schema: schema} do
      data = [1, 2, 3]
      assert valid?(schema, data)
    end

    test "additional items are not permitted", %{schema: schema} do
      data = [1, 2, 3, 4]
      refute valid?(schema, data)
    end
  end

  describe "additionalItems as false without items" do
    setup do
      %{schema: ~s(
        {
          "additionalItems": false
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "items defaults to empty schema so everything is valid", %{
      schema: schema
    } do
      data = [1, 2, 3, 4, 5]
      assert valid?(schema, data)
    end

    test "ignores non-arrays", %{schema: schema} do
      data = %{"foo" => "bar"}
      assert valid?(schema, data)
    end
  end

  describe "additionalItems are allowed by default" do
    setup do
      %{schema: ~s(
        {
          "items": [
            {
              "type": "integer"
            }
          ]
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "only the first item is validated", %{schema: schema} do
      data = [1, "foo", false]
      assert valid?(schema, data)
    end
  end
end
