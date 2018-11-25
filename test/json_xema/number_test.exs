defmodule Xema.NumberTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2, validate: 2]

  describe "number schema:" do
    setup do
      %{schema: JsonXema.new(~s({"type": "number"}))}
    end

    test "validate/2 with a float", %{schema: schema} do
      assert validate(schema, 2.3) == :ok
    end

    test "validate/2 with an integer", %{schema: schema} do
      assert validate(schema, 2) == :ok
    end

    test "validate/2 with a string", %{schema: schema} do
      expected = {:error, %{type: :number, value: "foo"}}

      assert validate(schema, "foo") == expected
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
      %{schema: JsonXema.new(~s(
        {"type": "number", "minimum": 2, "maximum": 4}
      ))}
    end

    test "validate/2 with a number in range", %{schema: schema} do
      assert validate(schema, 2.0) == :ok
      assert validate(schema, 3.0) == :ok
      assert validate(schema, 4.0) == :ok
    end

    test "validate/2 with a too small number", %{schema: schema} do
      expected = {:error, %{minimum: 2, value: 1.0}}

      assert validate(schema, 1.0) == expected
    end

    test "validate/2 with a too big number", %{schema: schema} do
      expected = {:error, %{value: 5.0, maximum: 4}}

      assert validate(schema, 5.0) == expected
    end
  end

  describe "number schema with exclusive range (draft-04):" do
    setup do
      %{
        schema: JsonXema.new(~s(
            {
              "type": "number",
              "minimum": 2,
              "maximum": 4,
              "exclusiveMinimum": true,
              "exclusiveMaximum": true
            }
          ))
      }
    end

    test "validate/2 with a number in range", %{schema: schema} do
      assert(validate(schema, 3.0) == :ok)
    end

    test "validate/2 with a too small number", %{schema: schema} do
      expected = {:error, %{exclusiveMinimum: true, minimum: 2, value: 1.0}}

      assert validate(schema, 1.0) == expected
    end

    test "validate/2 with a minimum number", %{schema: schema} do
      expected = {:error, %{minimum: 2, exclusiveMinimum: true, value: 2.0}}

      assert validate(schema, 2.0) == expected
    end

    test "validate/2 with a maximum number", %{schema: schema} do
      expected = {:error, %{value: 4.0, maximum: 4, exclusiveMaximum: true}}

      assert validate(schema, 4.0) == expected
    end

    test "validate/2 with a too big number", %{schema: schema} do
      expected = {:error, %{value: 5.0, maximum: 4, exclusiveMaximum: true}}

      assert validate(schema, 5.0) == expected
    end
  end

  describe "number schema with exclusive range (draft-06):" do
    setup do
      %{
        schema: JsonXema.new(~s(
            {
              "type": "number",
              "exclusiveMinimum": 2,
              "exclusiveMaximum": 4
            }
          ))
      }
    end

    test "validate/2 with a number in range", %{schema: schema} do
      assert(validate(schema, 3.0) == :ok)
    end

    test "validate/2 with a too small number", %{schema: schema} do
      expected = {:error, %{exclusiveMinimum: 2, value: 1.0}}

      assert validate(schema, 1.0) == expected
    end

    test "validate/2 with a minimum number", %{schema: schema} do
      expected = {:error, %{exclusiveMinimum: 2, value: 2.0}}

      assert validate(schema, 2.0) == expected
    end

    test "validate/2 with a maximum number", %{schema: schema} do
      expected = {:error, %{value: 4.0, exclusiveMaximum: 4}}

      assert validate(schema, 4.0) == expected
    end

    test "validate/2 with a too big number", %{schema: schema} do
      expected = {:error, %{value: 5.0, exclusiveMaximum: 4}}

      assert validate(schema, 5.0) == expected
    end
  end

  describe "number schema with multiple-of:" do
    setup do
      %{schema: JsonXema.new(~s(
        {"type": "number", "multipleOf": 1.2}
      ))}
    end

    test "validate/2 with a valid number", %{schema: schema} do
      assert(validate(schema, 3.6) == :ok)
    end

    test "validate/2 with an invalid number", %{schema: schema} do
      expected = {:error, %{value: 6.2, multipleOf: 1.2}}

      assert validate(schema, 6.2) == expected
    end
  end

  describe "number schema with enum:" do
    setup do
      %{schema: JsonXema.new(~s(
        {"type": "number", "enum": [1.2, 1.3, 3.3]}
      ))}
    end

    test "with a value from the enum", %{schema: schema} do
      assert(validate(schema, 1.3) == :ok)
    end

    test "with a value that is not in the enum", %{schema: schema} do
      expected = {:error, %{enum: [1.2, 1.3, 3.3], value: 2}}

      assert validate(schema, 2) == expected
    end
  end
end
