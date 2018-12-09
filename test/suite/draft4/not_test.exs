defmodule Draft4.NotTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "not" do
    setup do
      %{schema: ~s(
        {
          "not": {
            "type": "integer"
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "allowed", %{schema: schema} do
      data = "foo"
      assert valid?(schema, data)
    end

    test "disallowed", %{schema: schema} do
      data = 1
      refute valid?(schema, data)
    end
  end

  describe "not multiple types" do
    setup do
      %{schema: ~s(
        {
          "not": {
            "type": [
              "integer",
              "boolean"
            ]
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid", %{schema: schema} do
      data = "foo"
      assert valid?(schema, data)
    end

    test "mismatch", %{schema: schema} do
      data = 1
      refute valid?(schema, data)
    end

    test "other mismatch", %{schema: schema} do
      data = true
      refute valid?(schema, data)
    end
  end

  describe "not more complex schema" do
    setup do
      %{schema: ~s(
        {
          "not": {
            "properties": {
              "foo": {
                "type": "string"
              }
            },
            "type": "object"
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "match", %{schema: schema} do
      data = 1
      assert valid?(schema, data)
    end

    test "other match", %{schema: schema} do
      data = %{"foo" => 1}
      assert valid?(schema, data)
    end

    test "mismatch", %{schema: schema} do
      data = %{"foo" => "bar"}
      refute valid?(schema, data)
    end
  end

  describe "forbidden property" do
    setup do
      %{schema: ~s(
        {
          "properties": {
            "foo": {
              "not": {}
            }
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "property present", %{schema: schema} do
      data = %{"bar" => 2, "foo" => 1}
      refute valid?(schema, data)
    end

    test "property absent", %{schema: schema} do
      data = %{"bar" => 1, "baz" => 2}
      assert valid?(schema, data)
    end
  end
end
