defmodule Xema.MultiTypeTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  alias JsonXema.SchemaError

  test "&new/1 called with a wrong type list raised an exception" do
    assert_raise SchemaError, fn ->
      ~s({"type": ["string", "foo"]}) |> Jason.decode!() |> JsonXema.new()
    end
  end

  describe "schema with type string or nil:" do
    setup do
      %{schema: ~s({
        "type": ["string", "null"],
        "minLength": 5
      }) |> Jason.decode!() |> JsonXema.new()}
    end

    test "with a string", %{schema: schema} do
      assert validate(schema, "foobar") == :ok
    end

    test "with an invalid string", %{schema: schema} do
      assert validate(schema, "foo") == {:error, %{minLength: 5, value: "foo"}}
    end

    test "with nil", %{schema: schema} do
      assert validate(schema, nil) == :ok
    end

    test "with integer", %{schema: schema} do
      assert validate(schema, 42) ==
               {:error, %{type: ["string", "null"], value: 42}}
    end
  end

  describe "property with type number or nil:" do
    setup do
      %{schema: ~s({
        "properties": {
          "foo": ["number", "null"]
        }
      }) |> Jason.decode!() |> JsonXema.new()}
    end

    test "with a number", %{schema: schema} do
      assert validate(schema, %{"foo" => 42}) == :ok
    end

    test "with nil", %{schema: schema} do
      assert validate(schema, %{"foo" => nil}) == :ok
    end

    test "with a string", %{schema: schema} do
      assert validate(schema, %{"foo" => "foo"}) ==
               {:error,
                %{
                  properties: %{
                    "foo" => %{type: ["number", "null"], value: "foo"}
                  }
                }}
    end
  end
end
