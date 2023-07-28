defmodule JsonXema.ObjectTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2, validate: 2]

  alias JsonXema.ValidationError

  describe "empty object schema:" do
    setup do
      %{schema: ~s({"type": "object"}) |> Jason.decode!() |> JsonXema.new()}
    end

    test "validate/2 with an empty map", %{schema: schema} do
      assert validate(schema, %{}) == :ok
    end

    test "validate/2 with a string", %{schema: schema} do
      assert {:error, error} = validate(schema, "foo")
      assert error == %ValidationError{reason: %{type: "object", value: "foo"}}
      assert Exception.message(error) == ~s|Expected "object", got "foo".|
    end

    test "valid?/2 with a valid value", %{schema: schema} do
      assert valid?(schema, %{})
    end

    test "valid?/2 with an invalid value", %{schema: schema} do
      refute valid?(schema, 55)
    end
  end

  describe "object schema with properties:" do
    setup do
      %{
        schema: ~s({
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
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with valid values", %{schema: schema} do
      assert validate(schema, %{foo: 2, bar: "bar"}) == :ok
      assert validate(schema, %{"foo" => 2, "bar" => "bar"}) == :ok
    end

    test "validate/2 with invalid values (atom keys)", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"foo" => "foo", "bar" => "bar"})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "foo" => %{type: "number", value: "foo"}
                 }
               }
             }

      assert Exception.message(error) == ~s|Expected "number", got "foo", at ["foo"].|

      assert {:error, error} = validate(schema, %{"foo" => "foo", "bar" => 2})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "foo" => %{type: "number", value: "foo"},
                   "bar" => %{type: "string", value: 2}
                 }
               }
             }

      assert Exception.message(error) == """
             Expected "string", got 2, at ["bar"].
             Expected "number", got "foo", at ["foo"].\
             """
    end

    test "validate/2 with invalid values (string keys)", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"foo" => "foo", "bar" => "bar"})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "foo" => %{type: "number", value: "foo"}
                 }
               }
             }

      assert Exception.message(error) == ~s|Expected "number", got "foo", at ["foo"].|
    end
  end

  describe "object schema with min/max properties:" do
    setup do
      %{
        schema: ~s({
          "type": "object",
          "minProperties": 2,
          "maxProperties": 3
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with too less properties", %{schema: schema} do
      assert {:error, error} = validate(schema, %{foo: 42})
      assert error == %ValidationError{reason: %{minProperties: 2, value: %{foo: 42}}}
      assert Exception.message(error) == ~s|Expected at least 2 properties, got %{foo: 42}.|
    end

    test "validate/2 with valid amount of properties", %{schema: schema} do
      assert validate(schema, %{foo: 42, bar: 44}) == :ok
    end

    test "validate/2 with too many properties", %{schema: schema} do
      assert {:error, error} = validate(schema, %{a: 1, b: 2, c: 3, d: 4})

      assert error == %ValidationError{
               reason: %{maxProperties: 3, value: %{a: 1, b: 2, c: 3, d: 4}}
             }

      assert Exception.message(error) =~ ~s|Expected at most 3 properties, got|
    end
  end

  describe "object schema without additional properties:" do
    setup do
      %{
        schema: ~s({
          "type": "object",
          "properties": {
            "foo": {
              "type": "number"
            }
          },
          "additionalProperties": false
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with valid map", %{schema: schema} do
      assert validate(schema, %{"foo" => 44}) == :ok
    end

    test "validate/2 with additional property", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"foo" => 44, "add" => 1})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "add" => %{additionalProperties: false}
                 }
               }
             }

      assert Exception.message(error) == ~s|Expected only defined properties, got key ["add"].|
    end

    test "validate/2 with additional properties", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"foo" => 44, "add" => 1, "plus" => 3})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "add" => %{additionalProperties: false},
                   "plus" => %{additionalProperties: false}
                 }
               }
             }

      assert Exception.message(error) == """
             Expected only defined properties, got key ["add"].
             Expected only defined properties, got key ["plus"].\
             """
    end
  end

  describe "object schema with specific additional properties:" do
    setup do
      %{
        schema: ~s({
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
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with valid additional property", %{schema: schema} do
      assert validate(schema, %{"foo" => "foo", "add" => 1}) == :ok
    end

    test "validate/2 with invalid additional property", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"foo" => "foo", "add" => "invalid"})

      assert error == %ValidationError{
               reason: %{
                 properties: %{"add" => %{type: "integer", value: "invalid"}}
               }
             }

      assert Exception.message(error) == ~s|Expected "integer", got "invalid", at ["add"].|
    end

    test "validate/2 with invalid additional properties", %{schema: schema} do
      assert {:error, error} =
               validate(schema, %{
                 "foo" => "foo",
                 "add" => "invalid",
                 "plus" => "+"
               })

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "add" => %{type: "integer", value: "invalid"},
                   "plus" => %{type: "integer", value: "+"}
                 }
               }
             }

      assert Exception.message(error) == """
             Expected "integer", got "invalid", at ["add"].
             Expected "integer", got "+", at ["plus"].\
             """
    end
  end

  describe "object schema with required property:" do
    setup do
      %{
        schema: ~s({
          "type": "object",
          "properties": {
            "foo": {
              "type": "number"
            }
          },
          "required": ["foo"]
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with required property (atom key)", %{schema: schema} do
      assert validate(schema, %{"foo" => 44}) == :ok
    end

    test "validate/2 with required property (string key)", %{schema: schema} do
      assert validate(schema, %{"foo" => 44}) == :ok
    end

    test "validate/2 with missing key", %{schema: schema} do
      assert {:error, error} = validate(schema, %{missing: 44})

      assert error == %ValidationError{
               reason: %{
                 required: ["foo"]
               }
             }

      assert Exception.message(error) == ~s|Required properties are missing: ["foo"].|
    end
  end

  describe "object schema with required properties" do
    setup do
      %{
        schema: ~s({
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
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 without required properties", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"b" => 3, "d" => 8})

      assert error == %ValidationError{
               reason: %{
                 required: ["a", "c"]
               }
             }

      assert Exception.message(error) == ~s|Required properties are missing: ["a", "c"].|
    end
  end

  describe "object schema with pattern properties:" do
    setup do
      %{
        schema: ~s({
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
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with valid map", %{schema: schema} do
      assert validate(schema, %{"s_1" => "foo", "i_1" => 42}) == :ok
    end

    test "validate/2 with invalid map", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"x_1" => 44})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "x_1" => %{additionalProperties: false}
                 }
               }
             }

      assert Exception.message(error) == ~s|Expected only defined properties, got key ["x_1"].|
    end
  end

  describe "'map' schema with property names like keywords" do
    setup do
      %{
        schema: ~s({
          "type": "object",
          "properties": {
            "map": {"type": "number"},
            "items": {"type": "number"},
            "properties": {"type": "number"}
          }
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with valid map", %{schema: schema} do
      assert validate(schema, %{map: 3, items: 5, properties: 4}) == :ok
    end
  end

  describe "object schema with dependencies list:" do
    setup do
      %{
        schema: ~s({
          "type": "object",
          "properties": {
            "a": {"type": "number"},
            "b": {"type": "number"},
            "c": {"type": "number"}
          },
          "dependencies": {
            "b": ["c"]
          }
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 without dependency", %{schema: schema} do
      assert validate(schema, %{a: 1}) == :ok
    end

    test "validate/2 with dependency", %{schema: schema} do
      assert validate(schema, %{a: 1, b: 2, c: 3}) == :ok
    end

    test "validate/2 with missing dependency", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"a" => 1, "b" => 2})

      assert error == %ValidationError{
               reason: %{
                 :dependencies => %{"b" => "c"}
               }
             }

      assert Exception.message(error) ==
               ~s|Dependencies for "b" failed. Missing required key "c".|
    end
  end

  describe "object schema with dependencies schema" do
    setup do
      %{
        schema: ~s({
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
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 without dependency", %{schema: schema} do
      assert validate(schema, %{a: 1}) == :ok
    end

    test "validate/2 with dependency", %{schema: schema} do
      assert validate(schema, %{a: 1, b: 2, c: 3}) == :ok
    end

    test "validate/2 with missing dependency", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"a" => 1, "b" => 2})

      assert error == %ValidationError{
               reason: %{
                 dependencies: %{"b" => %{required: ["c"]}}
               }
             }

      assert Exception.message(error) == """
             Dependencies for "b" failed.
               Required properties are missing: ["c"].\
             """
    end
  end

  describe "In for a penny, in for a pound." do
    setup do
      %{
        schema: ~s({
          "type": "object",
          "dependencies": {
            "penny": ["pound"]
          }
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "a cent", %{schema: schema} do
      assert valid?(schema, %{cent: 1})
    end

    test "a pound", %{schema: schema} do
      assert valid?(schema, %{pound: 1})
    end

    test "a penny and a pound", %{schema: schema} do
      assert valid?(schema, %{penny: 1, pound: 1})
    end

    test "a penny", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"penny" => 1})
      assert error == %ValidationError{reason: %{dependencies: %{"penny" => "pound"}}}

      assert Exception.message(error) ==
               ~s|Dependencies for "penny" failed. Missing required key "pound".|
    end
  end

  describe "propertyNames validation" do
    setup do
      %{schema: ~s(
        {
          "propertyNames": {
            "maxLength": 3
          }
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "all property names valid", %{schema: schema} do
      data = %{"f" => %{}, "foo" => %{}}
      assert validate(schema, data) == :ok
    end

    test "some property names invalid", %{schema: schema} do
      data = %{"foo" => %{}, "foobar" => %{}}
      assert {:error, error} = validate(schema, data)

      assert error == %ValidationError{
               reason: %{
                 propertyNames: [{"foobar", %{maxLength: 3, value: "foobar"}}],
                 value: ["foo", "foobar"]
               }
             }

      assert Exception.message(error) == """
             Invalid property names.
               "foobar" : Expected maximum length of 3, got "foobar".\
             """
    end
  end

  describe "object schema with required property in snake case:" do
    setup do
      %{
        schema: ~s({
          "type": "object",
          "properties": {
            "foo_bar": {"type": "integer"}
          },
          "required": ["foo_bar"]
        }) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "with valid data", %{schema: schema} do
      assert validate(schema, %{"foo_bar" => 5}) == :ok
    end

    test "with invalid data", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"foo_bar" => "baz"})

      assert error == %ValidationError{
               reason: %{
                 properties: %{"foo_bar" => %{type: "integer", value: "baz"}}
               }
             }
    end

    test "with an empty map", %{schema: schema} do
      assert {:error, error} = validate(schema, %{})

      assert error == %ValidationError{
               message: nil,
               reason: %{required: ["foo_bar"]}
             }
    end
  end
end
