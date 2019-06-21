defmodule Xema.BooleanSchemaTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2, validate: 2]

  alias JsonXema.ValidationError

  describe "true schema:" do
    setup do
      %{schema: "true" |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid?/2 returns always true", %{schema: schema} do
      assert valid?(schema, true)
      assert valid?(schema, 42)
      assert valid?(schema, "foo")
      assert valid?(schema, [])
      assert valid?(schema, %{})
    end

    test "validate/2 returns always :ok", %{schema: schema} do
      assert(validate(schema, true) == :ok)
      assert(validate(schema, 42) == :ok)
      assert(validate(schema, "foo") == :ok)
      assert(validate(schema, []) == :ok)
      assert(validate(schema, %{}) == :ok)
    end
  end

  describe "false schema:" do
    setup do
      %{schema: "false" |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid?/2 returns always false", %{schema: schema} do
      refute valid?(schema, true)
      refute valid?(schema, 42)
      refute valid?(schema, "foo")
      refute valid?(schema, [])
      refute valid?(schema, %{})
    end

    test "validate/2 returns always {:error, %{type: false}}", %{schema: schema} do
      assert(validate(schema, true) == {:error, %ValidationError{reason: %{type: false}}})
      assert(validate(schema, 42) == {:error, %ValidationError{reason: %{type: false}}})
      assert(validate(schema, "foo") == {:error, %ValidationError{reason: %{type: false}}})
      assert(validate(schema, []) == {:error, %ValidationError{reason: %{type: false}}})
      assert(validate(schema, %{}) == {:error, %ValidationError{reason: %{type: false}}})
    end

    test "error message", %{schema: schema} do
      assert {:error, error} = validate(schema, "foo")
      assert Exception.message(error) == "Schema always fails validation."
    end
  end

  describe "all_of with boolean schemas, all true:" do
    setup do
      %{
        schema: ~s({"all_of": [true, true]}) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "valid?/2 returns always true", %{schema: schema} do
      assert valid?(schema, true)
      assert valid?(schema, 42)
      assert valid?(schema, "foo")
      assert valid?(schema, [])
      assert valid?(schema, %{})
    end
  end
end
