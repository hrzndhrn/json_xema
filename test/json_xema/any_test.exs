defmodule JsonXema.AnyTest do
  use ExUnit.Case

  import JsonXema, only: [is_valid?: 2, validate: 2]

  describe "'any' schema" do
    setup do
      %{schema: JsonXema.new("{}")}
    end

    test "type", %{schema: schema} do
      assert schema.content.as == "any"
    end

    test "is_valid?/2 with a string", %{schema: schema} do
      assert is_valid?(schema, "foo")
    end

    test "is_valid?/2 with a number", %{schema: schema} do
      assert is_valid?(schema, 42)
    end

    test "is_valid?/2 with nil", %{schema: schema} do
      assert is_valid?(schema, nil)
    end

    test "is_valid?/2 with a list", %{schema: schema} do
      assert is_valid?(schema, [1, 2, 3])
    end

    test "validate/2 with a string", %{schema: schema} do
      assert validate(schema, "foo") == :ok
    end

    test "validate/2 with a number", %{schema: schema} do
      assert validate(schema, 42) == :ok
    end

    test "validate/2 with nil", %{schema: schema} do
      assert validate(schema, nil) == :ok
    end

    test "validate/2 with a list", %{schema: schema} do
      assert validate(schema, [1, 2, 3]) == :ok
    end
  end

  describe "'any' schema with enum:" do
    setup do
      %{
        schema: JsonXema.new(~s({
            "enum" : [1, 1.2, [1], "foo"]
      }))
      }
    end

    test "validate/2 with a value from the enum", %{schema: schema} do
      assert validate(schema, 1) == :ok
      assert validate(schema, 1.2) == :ok
      assert validate(schema, "foo") == :ok
      assert validate(schema, [1]) == :ok
    end

    test "validate/2 with a value that is not in the enum", %{schema: schema} do
      expected = {:error, %{value: 2, enum: [1, 1.2, [1], "foo"]}}

      assert validate(schema, 2) == expected
    end

    test "is_valid?/2 with a valid value", %{schema: schema} do
      assert is_valid?(schema, 1)
    end

    test "is_valid?/2 with an invalid value", %{schema: schema} do
      refute is_valid?(schema, 5)
    end
  end

  describe "keyword not:" do
    setup do
      %{schema: JsonXema.new(~s({"not" : {"type" : "integer"}}))}
    end

    test "type", %{schema: schema} do
      assert schema.content.as == "any"
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, "foo") == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, 1) == {:error, :not}
    end
  end

  describe "nested keyword not:" do
    setup do
      %{
        schema: JsonXema.new(~s(
            {
              "type": "object",
              "properties": {
                "foo": {
                  "not": {
                    "type": "string",
                    "min_length": 3
                  }
                }
              }
            }
          ))
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, %{foo: ""}) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, %{foo: "foo"}) == {:error, %{properties: %{foo: :not}}}
    end
  end

  describe "keyword allOf:" do
    setup do
      %{
        schema: JsonXema.new(~s(
            {
              "allOf": [
                {"type": "integer"},
                {"type": "integer", "minimum": 0}
              ]
            }
          ))
      }
    end

    test "type", %{schema: schema} do
      assert schema.content.as == "any"
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 1) == :ok
    end

    test "validate/2 with an imvalid value", %{schema: schema} do
      assert validate(schema, -1) == {:error, :allOf}
    end
  end

  describe "keyword anyOf:" do
    setup do
      %{
        schema: JsonXema.new(~s(
            {"any_of": [
              {"type": "null"},
              {"type": "integer", "minimum": 1}
            ]}
          ))
      }
    end

    test "type", %{schema: schema} do
      assert schema.content.as == "any"
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 1) == :ok
      assert validate(schema, nil) == :ok
    end

    test "validate/2 with an imvalid value", %{schema: schema} do
      assert validate(schema, "foo") == {:error, :anyOf}
    end
  end

  describe "keyword one_of (multiple_of):" do
    setup do
      %{
        schema: JsonXema.new(~s(
            {"oneOf": [
              {
                "type": "integer",
                "multipleOf": 3
              }, {
                "type": "integer",
                "multipleOf": 5
              }
            ]}
          ))
      }
    end

    test "type", %{schema: schema} do
      assert schema.content.as == "any"
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 9) == :ok
      assert validate(schema, 10) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, 15) == {:error, :oneOf}
      assert validate(schema, 4) == {:error, :oneOf}
    end
  end

  describe "keyword one_of (multiple_of integer):" do
    setup do
      %{
        schema: JsonXema.new(~s(
            {
              "type": "integer",
              "oneOf": [
                {"multipleOf": 3},
                {"multipleOf": 5}
              ]
            }
          ))
      }
    end

    test "type", %{schema: schema} do
      assert schema.content.as == "integer"
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 9) == :ok
      assert validate(schema, 10) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, 15) == {:error, :oneOf}
      assert validate(schema, 4) == {:error, :oneOf}
    end
  end
end
