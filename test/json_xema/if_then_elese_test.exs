defmodule JsonXema.IfThenElseTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  alias JsonXema.ValidationError

  describe "if and then without else" do
    setup do
      %{schema: ~s(
        {
          "if": {
            "exclusiveMaximum": 0
          },
          "then": {
            "minimum": -10
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid through then", %{schema: schema} do
      data = -1
      assert validate(schema, data) == :ok
    end

    test "invalid through then", %{schema: schema} do
      data = -100
      assert {:error, error} = validate(schema, data)
      assert error == %ValidationError{reason: %{then: %{minimum: -10, value: -100}}}

      assert Exception.message(error) == """
             Schema for then does not match.
               Value -100 is less than minimum value of -10.\
             """
    end

    test "valid when if test fails", %{schema: schema} do
      data = 3
      assert validate(schema, data) == :ok
    end
  end

  describe "if and else without then" do
    setup do
      %{schema: ~s(
        {
          "else": {
            "multipleOf": 2
          },
          "if": {
            "exclusiveMaximum": 0
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid when if test passes", %{schema: schema} do
      data = -1
      assert validate(schema, data) == :ok
    end

    test "valid through else", %{schema: schema} do
      data = 4
      assert validate(schema, data) == :ok
    end

    test "invalid through else", %{schema: schema} do
      data = 3
      assert {:error, error} = validate(schema, data)
      assert error == %ValidationError{reason: %{else: %{multipleOf: 2, value: 3}}}

      assert Exception.message(error) == """
             Schema for else does not match.
               Value 3 is not a multiple of 2.\
             """
    end
  end

  describe "validate against correct branch, then vs else" do
    setup do
      %{schema: ~s(
        {
          "else": {
            "multipleOf": 2
          },
          "if": {
            "exclusiveMaximum": 0
          },
          "then": {
            "minimum": -10
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "valid through then", %{schema: schema} do
      data = -1
      assert validate(schema, data) == :ok
    end

    test "invalid through then", %{schema: schema} do
      data = -100
      assert {:error, error} = validate(schema, data)
      assert error == %ValidationError{reason: %{then: %{minimum: -10, value: -100}}}

      assert Exception.message(error) == """
             Schema for then does not match.
               Value -100 is less than minimum value of -10.\
             """
    end

    test "valid through else", %{schema: schema} do
      data = 4
      assert validate(schema, data) == :ok
    end

    test "invalid through else", %{schema: schema} do
      data = 3
      assert {:error, error} = validate(schema, data)
      assert error == %ValidationError{reason: %{else: %{multipleOf: 2, value: 3}}}

      assert Exception.message(error) == """
             Schema for else does not match.
               Value 3 is not a multiple of 2.\
             """
    end
  end
end
