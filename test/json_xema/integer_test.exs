defmodule JsonXema.IntegerTest do
  use ExUnit.Case, async: true

  import AssertBlame
  import JsonXema, only: [valid?: 2, validate: 2, validate!: 2]

  alias JsonXema.ValidationError

  describe "'integer' schema" do
    setup do
      %{
        schema: ~s({"type" : "integer"}) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with an integer", %{schema: schema} do
      assert validate(schema, 2) == :ok
    end

    test "validate/2 with a float", %{schema: schema} do
      assert {:error, error} = validate(schema, 2.3)
      assert error == %ValidationError{reason: %{type: "integer", value: 2.3}}
      assert Exception.message(error) == ~s|Expected "integer", got 2.3.|
    end

    test "validate!/2 with a float", %{schema: schema} do
      message = ~s|Expected "integer", got 2.3.|
      error = assert_raise ValidationError, message, fn -> validate!(schema, 2.3) end
      assert error.reason == %{type: "integer", value: 2.3}
    end

    test "validate!/2 with a float (blame)", %{schema: schema} do
      message = ~s|Expected "integer", got 2.3.|
      assert_blame(ValidationError, message, fn -> validate!(schema, 2.3) end)
    end

    test "validate/2 with a string", %{schema: schema} do
      assert {:error, error} = validate(schema, "foo")
      assert error == %ValidationError{reason: %{type: "integer", value: "foo"}}
      assert Exception.message(error) == ~s|Expected "integer", got "foo".|
    end

    test "valid?/2 with a valid value", %{schema: schema} do
      assert valid?(schema, 5)
    end

    test "valid?/2 with an invalid value", %{schema: schema} do
      refute(valid?(schema, [1]))
    end
  end

  describe "'integer' schema with range" do
    setup do
      %{
        schema: ~s({
            "type" : "integer",
            "minimum" : 2,
            "maximum" : 4
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a integer in range", %{schema: schema} do
      assert validate(schema, 2) == :ok
      assert validate(schema, 3) == :ok
      assert validate(schema, 4) == :ok
    end

    test "validate/2 with a too small integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 1)
      assert error == %ValidationError{reason: %{value: 1, minimum: 2}}
      assert Exception.message(error) == ~s|Value 1 is less than minimum value of 2.|
    end

    test "validate/2 with a too big integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 5)
      assert error == %ValidationError{reason: %{value: 5, maximum: 4}}
      assert Exception.message(error) == ~s|Value 5 exceeds maximum value of 4.|
    end
  end

  describe "'integer' schema with exclusive range" do
    setup do
      %{
        schema: ~s({
            "type" : "integer",
            "minimum" : 2,
            "maximum" : 4,
            "exclusiveMaximum" : true,
            "exclusiveMinimum" : true
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a integer in range", %{schema: schema} do
      assert(validate(schema, 3) == :ok)
    end

    test "validate/2 with a too small integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 1)
      assert error == %ValidationError{reason: %{value: 1, minimum: 2, exclusiveMinimum: true}}
      assert Exception.message(error) == ~s|Value 1 is less than minimum value of 2.|
    end

    test "validate/2 with a minimum integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 2)
      assert error == %ValidationError{reason: %{minimum: 2, exclusiveMinimum: true, value: 2}}
      assert Exception.message(error) == ~s|Value 2 equals exclusive minimum value of 2.|
    end

    test "validate/2 with a maximum integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 4)
      assert error == %ValidationError{reason: %{value: 4, maximum: 4, exclusiveMaximum: true}}
      assert Exception.message(error) == ~s|Value 4 equals exclusive maximum value of 4.|
    end

    test "validate/2 with a too big integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 5)
      assert error == %ValidationError{reason: %{value: 5, maximum: 4, exclusiveMaximum: true}}
      assert Exception.message(error) == ~s|Value 5 exceeds maximum value of 4.|
    end
  end

  describe "'integer' schema with multiple-of" do
    setup do
      %{schema: ~s({
          "type" : "integer",
          "multipleOf" : 2
      }) |> Jason.decode!() |> JsonXema.new()}
    end

    test "validate/2 with a valid integer", %{schema: schema} do
      assert(validate(schema, 6) == :ok)
    end

    test "validate/2 with an invalid integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 7)
      assert error == %ValidationError{reason: %{value: 7, multipleOf: 2}}
      assert Exception.message(error) == ~s|Value 7 is not a multiple of 2.|
    end
  end

  describe "'integer' schema with enum" do
    setup do
      %{schema: ~s({
          "type" : "integer",
          "enum" : [1, 3]
      }) |> Jason.decode!() |> JsonXema.new()}
    end

    test "with a value from the enum", %{schema: schema} do
      assert validate(schema, 3) == :ok
    end

    test "with a value that is not in the enum", %{schema: schema} do
      assert {:error, error} = validate(schema, 2)
      assert error == %ValidationError{reason: %{enum: [1, 3], value: 2}}
      assert Exception.message(error) == ~s|Value 2 is not defined in enum.|
    end
  end
end
