defmodule Xema.MultiTypeTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  alias JsonXema.SchemaError
  alias JsonXema.ValidationError

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
      assert {:error, error} = validate(schema, "foo")
      assert error == %ValidationError{reason: %{minLength: 5, value: "foo"}}
      assert Exception.message(error) == ~s|Expected minimum length of 5, got "foo".|
    end

    test "with nil", %{schema: schema} do
      assert validate(schema, nil) == :ok
    end

    test "with integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 42)
      assert error == %ValidationError{reason: %{type: ["string", "null"], value: 42}}
      assert Exception.message(error) == ~s|Expected ["string", "null"], got 42.|
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
      assert {:error, error} = validate(schema, %{"foo" => "foo"})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "foo" => %{type: ["number", "null"], value: "foo"}
                 }
               }
             }

      assert Exception.message(error) == ~s|Expected ["number", "null"], got "foo", at ["foo"].|
    end
  end
end
