defmodule JsonXema.StringTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2, validate: 2]

  alias JsonXema.ValidationError

  describe "string schema:" do
    setup do
      %{schema: ~s({"type": "string"}) |> Jason.decode!() |> JsonXema.new()}
    end

    test "validate/2 with a string", %{schema: schema} do
      assert validate(schema, "foo") == :ok
    end

    test "validate/2 with a number", %{schema: schema} do
      assert {:error, error} = validate(schema, 1)
      assert error == %ValidationError{reason: %{type: "string", value: 1}}
      assert Exception.message(error) == ~s|Expected "string", got 1.|
    end

    test "validate/2 with nil", %{schema: schema} do
      assert {:error, error} = validate(schema, nil)
      assert error == %ValidationError{reason: %{type: "string", value: nil}}
    end

    test "valid?/2 with a valid value", %{schema: schema} do
      assert valid?(schema, "foo")
    end

    test "valid?/2 with an invalid value", %{schema: schema} do
      refute valid?(schema, [])
    end
  end

  describe "string schema with restricted length:" do
    setup do
      %{
        schema: ~s({
          "type": "string",
          "minLength": 3,
          "maxLength": 4
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a proper string", %{schema: schema} do
      assert validate(schema, "foo") == :ok
    end

    test "validate/2 with a too short string", %{schema: schema} do
      assert {:error, error} = validate(schema, "f")
      assert error == %ValidationError{reason: %{minLength: 3, value: "f"}}
      assert Exception.message(error) == ~s|Expected minimum length of 3, got "f".|
    end

    test "validate/2 with a too long string", %{schema: schema} do
      assert {:error, error} = validate(schema, "foobar")
      assert error == %ValidationError{reason: %{maxLength: 4, value: "foobar"}}
      assert Exception.message(error) == ~s|Expected maximum length of 4, got "foobar".|
    end
  end

  describe "string schema with pattern" do
    setup do
      %{
        schema: ~s({
          "type": "string",
          "pattern": "^.+match.+$"
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a matching string", %{schema: schema} do
      assert validate(schema, "a match a") == :ok
    end

    test "validate/2 with a none matching string", %{schema: schema} do
      assert {:error, error} = validate(schema, "a to a")
      assert error == %ValidationError{reason: %{value: "a to a", pattern: ~r/^.+match.+$/}}

      assert Exception.message(error) ==
               ~s|Pattern ~r/^.+match.+$/ does not match value "a to a".|
    end
  end

  describe "string schema with enum" do
    setup do
      %{
        schema: ~s({
          "type": "string",
          "enum": ["one", "two", "foo_bar"]
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a value from the enum", %{schema: schema} do
      assert validate(schema, "two") == :ok
      assert validate(schema, "foo_bar") == :ok
    end

    test "validate/2 with a value that is not in the enum", %{schema: schema} do
      assert {:error, error} = validate(schema, "foo")
      assert error == %ValidationError{reason: %{enum: ["one", "two", "foo_bar"], value: "foo"}}
      assert Exception.message(error) == ~s|Value "foo" is not defined in enum.|
    end
  end
end
