defmodule Xema.NumberTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2, validate: 2]

  alias JsonXema.ValidationError

  describe "number schema:" do
    setup do
      %{schema: ~s({"type": "number"}) |> Jason.decode!() |> JsonXema.new()}
    end

    test "validate/2 with a float", %{schema: schema} do
      assert validate(schema, 2.3) == :ok
    end

    test "validate/2 with an integer", %{schema: schema} do
      assert validate(schema, 2) == :ok
    end

    test "validate/2 with a string", %{schema: schema} do
      assert {:error, error} = validate(schema, "foo")
      assert error == %ValidationError{reason: %{type: "number", value: "foo"}}
      assert Exception.message(error) == ~s|Expected "number", got "foo".|
    end

    test "valid?/2 with a valid value", %{schema: schema} do
      assert valid?(schema, 5.6)
    end

    test "valid?/2 with an invalid value", %{schema: schema} do
      refute valid?(schema, [1])
    end
  end

  describe "number schema with range:" do
    setup do
      %{schema: ~s(
        {"type": "number", "minimum": 2, "maximum": 4}
      ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "validate/2 with a number in range", %{schema: schema} do
      assert validate(schema, 2.0) == :ok
      assert validate(schema, 3.0) == :ok
      assert validate(schema, 4.0) == :ok
    end

    test "validate/2 with a too small number", %{schema: schema} do
      assert {:error, error} = validate(schema, 1.0)
      assert error == %ValidationError{reason: %{minimum: 2, value: 1.0}}
      assert Exception.message(error) == ~s|Value 1.0 is less than minimum value of 2.|
    end

    test "validate/2 with a too big number", %{schema: schema} do
      assert {:error, error} = validate(schema, 5.0)
      assert error == %ValidationError{reason: %{value: 5.0, maximum: 4}}
      assert Exception.message(error) == ~s|Value 5.0 exceeds maximum value of 4.|
    end
  end

  describe "number schema with exclusive range (draft-04):" do
    setup do
      %{
        schema: ~s(
            {
              "type": "number",
              "minimum": 2,
              "maximum": 4,
              "exclusiveMinimum": true,
              "exclusiveMaximum": true
            }
        ) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a number in range", %{schema: schema} do
      assert(validate(schema, 3.0) == :ok)
    end

    test "validate/2 with a too small number", %{schema: schema} do
      assert {:error, error} = validate(schema, 1.0)
      assert error == %ValidationError{reason: %{exclusiveMinimum: true, minimum: 2, value: 1.0}}
      assert Exception.message(error) == ~s|Value 1.0 is less than minimum value of 2.|
    end

    test "validate/2 with a minimum number", %{schema: schema} do
      assert {:error, error} = validate(schema, 2.0)
      assert error == %ValidationError{reason: %{minimum: 2, exclusiveMinimum: true, value: 2.0}}
      assert Exception.message(error) == ~s|Value 2.0 equals exclusive minimum value of 2.|
    end

    test "validate/2 with a maximum number (float)", %{schema: schema} do
      assert {:error, error} = validate(schema, 4.0)
      assert error == %ValidationError{reason: %{value: 4.0, maximum: 4, exclusiveMaximum: true}}
      assert Exception.message(error) == ~s|Value 4.0 equals exclusive maximum value of 4.|
    end

    test "validate/2 with a maximum number (integer)", %{schema: schema} do
      assert {:error, error} = validate(schema, 4)
      assert error == %ValidationError{reason: %{value: 4, maximum: 4, exclusiveMaximum: true}}
      assert Exception.message(error) == ~s|Value 4 equals exclusive maximum value of 4.|
    end

    test "validate/2 with a too big number", %{schema: schema} do
      assert {:error, error} = validate(schema, 5.0)
      assert error == %ValidationError{reason: %{value: 5.0, maximum: 4, exclusiveMaximum: true}}
      assert Exception.message(error) == ~s|Value 5.0 exceeds maximum value of 4.|
    end
  end

  describe "number schema with exclusive range (draft-06):" do
    setup do
      %{
        schema: ~s(
            {
              "type": "number",
              "exclusiveMinimum": 2,
              "exclusiveMaximum": 4
            }
        ) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a number in range", %{schema: schema} do
      assert(validate(schema, 3.0) == :ok)
    end

    test "validate/2 with a too small number", %{schema: schema} do
      assert {:error, error} = validate(schema, 1.0)
      assert error == %ValidationError{reason: %{exclusiveMinimum: 2, value: 1.0}}
      assert Exception.message(error) == ~s|Value 1.0 is less than minimum value of 2.|
    end

    test "validate/2 with a minimum number", %{schema: schema} do
      assert {:error, error} = validate(schema, 2.0)
      assert error == %ValidationError{reason: %{exclusiveMinimum: 2, value: 2.0}}
      assert Exception.message(error) == ~s|Value 2 equals exclusive minimum value of 2.|
    end

    test "validate/2 with a maximum number (float)", %{schema: schema} do
      assert {:error, error} = validate(schema, 4.0)
      assert error == %ValidationError{reason: %{value: 4.0, exclusiveMaximum: 4}}
      assert Exception.message(error) == ~s|Value 4 equals exclusive maximum value of 4.|
    end

    test "validate/2 with a maximum number (integer)", %{schema: schema} do
      assert {:error, error} = validate(schema, 4)
      assert error == %ValidationError{reason: %{value: 4, exclusiveMaximum: 4}}
      assert Exception.message(error) == ~s|Value 4 equals exclusive maximum value of 4.|
    end

    test "validate/2 with a too big number", %{schema: schema} do
      assert {:error, error} = validate(schema, 5.0)
      assert error == %ValidationError{reason: %{value: 5.0, exclusiveMaximum: 4}}
      assert Exception.message(error) == ~s|Value 5.0 exceeds maximum value of 4.|
    end
  end

  describe "number schema with multiple-of:" do
    setup do
      %{schema: ~s(
        {"type": "number", "multipleOf": 1.2}
      ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "validate/2 with a valid number", %{schema: schema} do
      assert(validate(schema, 3.6) == :ok)
    end

    test "validate/2 with an invalid number", %{schema: schema} do
      assert {:error, error} = validate(schema, 6.2)
      assert error == %ValidationError{reason: %{value: 6.2, multipleOf: 1.2}}
      assert Exception.message(error) == ~s|Value 6.2 is not a multiple of 1.2.|
    end
  end

  describe "number schema with enum:" do
    setup do
      %{schema: ~s(
        {"type": "number", "enum": [1.2, 1.3, 3.3]}
      ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "with a value from the enum", %{schema: schema} do
      assert(validate(schema, 1.3) == :ok)
    end

    test "with a value that is not in the enum", %{schema: schema} do
      assert {:error, error} = validate(schema, 2)
      assert error == %ValidationError{reason: %{enum: [1.2, 1.3, 3.3], value: 2}}
      assert Exception.message(error) == ~s|Value 2 is not defined in enum.|
    end
  end
end
