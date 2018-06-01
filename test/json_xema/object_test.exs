defmodule JsonXema.ObjectTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [is_valid?: 2, validate: 2]

  describe "empty object schema:" do
    setup do
      %{schema: JsonXema.new(~s({"type": "object"}))}
    end

    test "validate/2 with an empty map", %{schema: schema} do
      assert validate(schema, %{}) == :ok
    end

    test "validate/2 with a string", %{schema: schema} do
      expected = {:error, %{type: :object, value: "foo"}}

      assert validate(schema, "foo") == expected
    end

    test "is_valid?/2 with a valid value", %{schema: schema} do
      assert is_valid?(schema, %{})
    end

    test "is_valid?/2 with an invalid value", %{schema: schema} do
      refute is_valid?(schema, 55)
    end
  end

  describe "object schema with properties:" do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "properties": {
            "foo": {
              "type": "number"
            },
            "bar": {
              "type": "string"
            },
            "who_knows": {
              "type": "string"
            }
          }
        }))
      }
    end

    test "validate/2 with valid values", %{schema: schema} do
      assert validate(schema, %{foo: 2, bar: "bar"}) == :ok
      assert validate(schema, %{"foo" => 2, "bar" => "bar"}) == :ok
    end

    test "validate/2 with invalid values (atom keys)", %{schema: schema} do
      assert validate(schema, %{foo: "foo", bar: "bar"}) ==
               {:error,
                %{
                  properties: %{
                    foo: %{type: :number, value: "foo"}
                  }
                }}

      assert validate(schema, %{foo: "foo", bar: 2}) ==
               {:error,
                %{
                  properties: %{
                    foo: %{type: :number, value: "foo"},
                    bar: %{type: :string, value: 2}
                  }
                }}
    end

    test "validate/2 with invalid values (string keys)", %{schema: schema} do
      assert validate(schema, %{"foo" => "foo", "bar" => "bar"}) ==
               {:error,
                %{
                  properties: %{
                    "foo" => %{type: :number, value: "foo"}
                  }
                }}
    end

    test "validate/2 with mixed map", %{schema: schema} do
      assert validate(schema, %{"foo" => 1, foo: 2}) ==
               {:error, %{properties: %{"foo" => :mixed_map}}}
    end
  end

  describe "object schema with min/max properties:" do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "minProperties": 2,
          "maxProperties": 3
        }))
      }
    end

    test "validate/2 with too less properties", %{schema: schema} do
      assert validate(schema, %{foo: 42}) == {:error, %{minProperties: 2}}
    end

    test "validate/2 with valid amount of properties", %{schema: schema} do
      assert validate(schema, %{foo: 42, bar: 44}) == :ok
    end

    test "validate/2 with too many properties", %{schema: schema} do
      assert validate(schema, %{a: 1, b: 2, c: 3, d: 4}) ==
               {:error, %{maxProperties: 3}}
    end
  end

  describe "object schema without additional properties:" do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "properties": {
            "foo": {
              "type": "number"
            }
          },
          "additionalProperties": false
        }))
      }
    end

    test "validate/2 with valid map", %{schema: schema} do
      assert validate(schema, %{foo: 44}) == :ok
      assert validate(schema, %{"foo" => 44}) == :ok
    end

    test "validate/2 with additional property", %{schema: schema} do
      assert validate(schema, %{foo: 44, add: 1}) ==
               {:error,
                %{
                  properties: %{
                    add: %{additionalProperties: false}
                  }
                }}
    end

    test "validate/2 with additional properties", %{schema: schema} do
      assert validate(schema, %{foo: 44, add: 1, plus: 3}) ==
               {:error,
                %{
                  properties: %{
                    add: %{additionalProperties: false},
                    plus: %{additionalProperties: false}
                  }
                }}
    end
  end

  describe "object schema with specific additional properties:" do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "properties": {
            "foo": {
              "type": "string",
              "minLength": 3
            }
          },
          "additionalProperties": {
            "type": "integer"
          }
        }))
      }
    end

    test "validate/2 with valid additional property", %{schema: schema} do
      assert validate(schema, %{foo: "foo", add: 1}) == :ok
    end

    test "validate/2 with invalid additional property", %{schema: schema} do
      assert validate(schema, %{foo: "foo", add: "invalid"}) ==
               {
                 :error,
                 %{
                   add: %{type: :integer, value: "invalid"}
                 }
               }
    end

    test "validate/2 with invalid additional properties", %{schema: schema} do
      assert validate(schema, %{foo: "foo", add: "invalid", plus: "+"}) ==
               {
                 :error,
                 %{
                   add: %{type: :integer, value: "invalid"},
                   plus: %{type: :integer, value: "+"}
                 }
               }
    end
  end

  describe "object schema with required property:" do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "properties": {
            "foo": {
              "type": "number"
            }
          },
          "required": ["foo"]
        }))
      }
    end

    test "validate/2 with required property (atom key)", %{schema: schema} do
      assert validate(schema, %{foo: 44}) == :ok
    end

    test "validate/2 with required property (string key)", %{schema: schema} do
      assert validate(schema, %{"foo" => 44}) == :ok
    end

    test "validate/2 with missing key", %{schema: schema} do
      assert validate(schema, %{missing: 44}) ==
               {:error,
                %{
                  required: ["foo"]
                }}
    end
  end

  describe "object schema with required properties" do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "properties": {
            "a": {
              "type": "number"
            },
            "b": {
              "type": "number"
            },
            "c": {
              "type": "number"
            }
          },
          "required": ["a", "b", "c"]
        }))
      }
    end

    test "validate/2 without required properties", %{schema: schema} do
      assert validate(schema, %{b: 3, d: 8}) ==
               {:error,
                %{
                  required: ["a", "c"]
                }}
    end
  end

  describe "object schema with pattern properties:" do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "patternProperties": {
            "^s_": {
              "type": "string"
            },
            "^i_": {
              "type": "number"
            }
          },
          "additionalProperties": false
        }))
      }
    end

    test "validate/2 with valid map", %{schema: schema} do
      assert validate(schema, %{s_1: "foo", i_1: 42}) == :ok
    end

    test "validate/2 with invalid map", %{schema: schema} do
      assert validate(schema, %{x_1: 44}) ==
               {:error,
                %{
                  properties: %{
                    x_1: %{additionalProperties: false}
                  }
                }}
    end
  end

  describe "'map' schema with property names like keywords" do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "properties": {
            "map": {"type": "number"},
            "items": {"type": "number"},
            "properties": {"type": "number"}
          }
        }))
      }
    end

    test "validate/2 with valid map", %{schema: schema} do
      assert validate(schema, %{map: 3, items: 5, properties: 4}) == :ok
    end
  end

  describe "object schema with dependencies list:" do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "properties": {
            "a": {"type": "number"},
            "b": {"type": "number"},
            "c": {"type": "number"}
          },
          "dependencies": {
            "b": ["c"]
          }
        }))
      }
    end

    test "validate/2 without dependency", %{schema: schema} do
      assert validate(schema, %{a: 1}) == :ok
    end

    test "validate/2 with dependency", %{schema: schema} do
      assert validate(schema, %{a: 1, b: 2, c: 3}) == :ok
    end

    test "validate/2 with missing dependency", %{schema: schema} do
      assert validate(schema, %{a: 1, b: 2}) ==
               {:error,
                %{
                  :dependencies => %{"b" => "c"}
                }}
    end
  end

  describe "object schema with dependencies schema" do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "properties": {
            "a": {"type": "number"},
            "b": {"type": "number"}
          },
          "dependencies": {
            "b": {
              "type": "object",
              "properties": {
                "c": {"type": "number"}
              },
              "required": ["c"]
            }
          }
        }))
      }
    end

    test "validate/2 without dependency", %{schema: schema} do
      assert validate(schema, %{a: 1}) == :ok
    end

    test "validate/2 with dependency", %{schema: schema} do
      assert validate(schema, %{a: 1, b: 2, c: 3}) == :ok
    end

    test "validate/2 with missing dependency", %{schema: schema} do
      assert validate(schema, %{a: 1, b: 2}) ==
               {:error,
                %{
                  dependencies: %{"b" => %{required: ["c"]}}
                }}
    end
  end

  describe "In for a penny, in for a pound." do
    setup do
      %{
        schema: JsonXema.new(~s({
          "type": "object",
          "dependencies": {
            "penny": ["pound"]
          }
        }))
      }
    end

    test "a cent", %{schema: schema} do
      assert is_valid?(schema, %{cent: 1})
    end

    test "a pound", %{schema: schema} do
      assert is_valid?(schema, %{pound: 1})
    end

    test "a penny and a pound", %{schema: schema} do
      assert is_valid?(schema, %{penny: 1, pound: 1})
    end

    test "a penny", %{schema: schema} do
      assert validate(schema, %{penny: 1}) ==
               {:error, %{dependencies: %{"penny" => "pound"}}}
    end
  end
end
