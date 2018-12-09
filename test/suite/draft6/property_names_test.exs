defmodule Draft6.PropertyNamesTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "propertyNames validation" do
    setup do
      %{schema: ~s(
        {
          "propertyNames": {
            "maxLength": 3
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "all property names valid", %{schema: schema} do
      data = %{"f" => %{}, "foo" => %{}}
      assert valid?(schema, data)
    end

    test "some property names invalid", %{schema: schema} do
      data = %{"foo" => %{}, "foobar" => %{}}
      refute valid?(schema, data)
    end

    test "object without properties is valid", %{schema: schema} do
      data = %{}
      assert valid?(schema, data)
    end

    test "ignores arrays", %{schema: schema} do
      data = [1, 2, 3, 4]
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

  describe "propertyNames with boolean schema true" do
    setup do
      %{schema: ~s(
        {
          "propertyNames": true
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "object with any properties is valid", %{schema: schema} do
      data = %{"foo" => 1}
      assert valid?(schema, data)
    end

    test "empty object is valid", %{schema: schema} do
      data = %{}
      assert valid?(schema, data)
    end
  end

  describe "propertyNames with boolean schema false" do
    setup do
      %{schema: ~s(
        {
          "propertyNames": false
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "object with any properties is invalid", %{schema: schema} do
      data = %{"foo" => 1}
      refute valid?(schema, data)
    end

    test "empty object is valid", %{schema: schema} do
      data = %{}
      assert valid?(schema, data)
    end
  end
end
