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
      assert validate(schema, 2.3) == {:error, %{type: "integer", value: 2.3}}
    end

    test "validate!/2 with a float", %{schema: schema} do
      validate!(schema, 2.3)
    rescue
      error ->
        assert %ValidationError{} = error
        assert error.message == "Validation failed!"
        assert error.reason == %{type: "integer", value: 2.3}
    end

    test "validate/2 with a string", %{schema: schema} do
      assert validate(schema, "foo") ==
               {:error, %{type: "integer", value: "foo"}}
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
      expected = {:error, %{value: 1, minimum: 2}}

      assert validate(schema, 1) == expected
    end

    test "validate/2 with a too big integer", %{schema: schema} do
      expected = {:error, %{value: 5, maximum: 4}}

      assert validate(schema, 5) == expected
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
      expected = {:error, %{value: 1, minimum: 2, exclusiveMinimum: true}}

      assert validate(schema, 1) == expected
    end

    test "validate/2 with a minimum integer", %{schema: schema} do
      expected = {:error, %{minimum: 2, exclusiveMinimum: true, value: 2}}

      assert validate(schema, 2) == expected
    end

    test "validate/2 with a maximum integer", %{schema: schema} do
      expected = {:error, %{value: 4, maximum: 4, exclusiveMaximum: true}}

      assert validate(schema, 4) == expected
    end

    test "validate/2 with a too big integer", %{schema: schema} do
      expected = {:error, %{value: 5, maximum: 4, exclusiveMaximum: true}}

      assert validate(schema, 5) == expected
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
      expected = {:error, %{value: 7, multipleOf: 2}}
      assert validate(schema, 7) == expected
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
      expected = {:error, %{enum: [1, 3], value: 2}}

      assert validate(schema, 2) == expected
    end
  end
end
