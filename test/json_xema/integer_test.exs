defmodule JsonXema.IntegerTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2, validate: 2, validate!: 2]

  alias Xema.ValidationError

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
    end

    test "validate!/2 with a float", %{schema: schema} do
      validate!(schema, 2.3)
    rescue
      error ->
        assert %ValidationError{} = error
        assert error.reason == %{type: "integer", value: 2.3}
        assert Exception.message(error) == ~s|Expected "integer", got 2.3.|
    end

    test "validate/2 with a string", %{schema: schema} do
      assert {:error, error} = validate(schema, "foo")
      assert error == %ValidationError{reason: %{type: "integer", value: "foo"}}
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
    end

    test "validate/2 with a too big integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 5)
      assert error == %ValidationError{reason: %{value: 5, maximum: 4}}
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
    end

    test "validate/2 with a minimum integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 2)
      assert error == %ValidationError{reason: %{minimum: 2, exclusiveMinimum: true, value: 2}}
    end

    test "validate/2 with a maximum integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 4)
      assert error == %ValidationError{reason: %{value: 4, maximum: 4, exclusiveMaximum: true}}
    end

    test "validate/2 with a too big integer", %{schema: schema} do
      assert {:error, error} = validate(schema, 5)
      assert error == %ValidationError{reason: %{value: 5, maximum: 4, exclusiveMaximum: true}}
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
    end
  end
end
