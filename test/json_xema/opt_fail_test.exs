defmodule JsonXema.OptFailTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 3]

  alias JsonXema.ValidationError

  test "throws ArgumentError for invalid fail option" do
    message = "the optional option :fail must be one of [:immediately, :early, :finally] when set"

    assert_raise ArgumentError, message, fn ->
      validate(
        JsonXema.new(%{"type" => "integer"}),
        5,
        fail: :unknown
      )
    end
  end

  describe "schema" do
    setup do
      schema =
        """
        {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "a": {
              "type": "object",
              "properties": {
                "foo": { "type": "integer" },
                "bar": { "type": "integer" }
              },
              "maxProperties": 3,
              "patternProperties": { "^str_": { "type": "string" } },
              "additionalProperties": false
            },
            "b": {
              "type": "array",
              "maxItems": 3,
              "items": { "type": "integer" },
              "uniqueItems": true
            }
          }
        }
        """
        |> Jason.decode!()
        |> JsonXema.new()

      %{
        schema: schema,
        valid: %{
          "a" => %{"foo" => 5, "bar" => 9, "str_baz" => "baz"},
          "b" => [1, 2, 3]
        },
        invalid: %{
          values: %{
            "a" => %{"foo" => "foo", "bar" => 9, "str_baz" => 7},
            "b" => [1, "2", "3"]
          },
          structure: %{
            "a" => %{"foo" => "foo", "bar" => 9, "str_baz" => 7, "more" => "things"},
            "b" => [1, "2", "3", :next, 1]
          }
        }
      }
    end

    test "validate/3 with valid data", %{schema: schema, valid: data} do
      assert validate(schema, data, fail: :immediately) == :ok
      assert validate(schema, data, fail: :early) == :ok
      assert validate(schema, data, fail: :finally) == :ok
    end

    test "validate/3 with [fail: :immediately] invalid.values",
         %{schema: schema, invalid: %{values: data}} do
      opts = [fail: :immediately]

      assert {:error, error} = validate(schema, data, opts)

      assert error == %ValidationError{
               message: nil,
               reason: %{
                 properties: %{
                   "a" => %{
                     properties: %{"str_baz" => %{type: "string", value: 7}}
                   }
                 }
               }
             }

      assert Exception.message(error) == ~s|Expected "string", got 7, at ["a", "str_baz"].|
    end

    test "validate/3 with [fail: :early] invalid.values",
         %{schema: schema, invalid: %{values: data}} do
      opts = [fail: :early]

      assert {:error, error} = validate(schema, data, opts)

      assert error == %ValidationError{
               message: nil,
               reason: %{
                 properties: %{
                   "a" => %{
                     properties: %{
                       "foo" => %{type: "integer", value: "foo"},
                       "str_baz" => %{type: "string", value: 7}
                     }
                   },
                   "b" => %{
                     items: %{
                       1 => %{type: "integer", value: "2"},
                       2 => %{type: "integer", value: "3"}
                     }
                   }
                 }
               }
             }

      assert Exception.message(error) == """
             Expected "integer", got "foo", at ["a", "foo"].
             Expected "string", got 7, at ["a", "str_baz"].
             Expected "integer", got "2", at ["b", 1].
             Expected "integer", got "3", at ["b", 2].\
             """
    end

    test "validate/3 with [fail: :finally] invalid.values",
         %{schema: schema, invalid: %{values: data}} do
      opts = [fail: :finally]

      assert {:error, error} = validate(schema, data, opts)

      assert error == %ValidationError{
               message: nil,
               reason: %{
                 properties: %{
                   "a" => %{
                     properties: %{
                       "foo" => %{type: "integer", value: "foo"},
                       "str_baz" => %{type: "string", value: 7}
                     }
                   },
                   "b" => %{
                     items: %{
                       1 => %{type: "integer", value: "2"},
                       2 => %{type: "integer", value: "3"}
                     }
                   }
                 }
               }
             }

      assert Exception.message(error) == """
             Expected "integer", got "foo", at ["a", "foo"].
             Expected "string", got 7, at ["a", "str_baz"].
             Expected "integer", got "2", at ["b", 1].
             Expected "integer", got "3", at ["b", 2].\
             """
    end

    test "validate/3 with [fail: :immediately] invalid.structure",
         %{schema: schema, invalid: %{structure: data}} do
      opts = [fail: :immediately]

      assert {:error, error} = validate(schema, data, opts)

      assert error == %ValidationError{
               message: nil,
               reason: %{
                 properties: %{
                   "a" => %{
                     value: %{
                       "bar" => 9,
                       "foo" => "foo",
                       "more" => "things",
                       "str_baz" => 7
                     },
                     maxProperties: 3
                   }
                 }
               }
             }

      assert Exception.message(error) == """
             Expected at most 3 properties, \
             got %{"bar" => 9, "foo" => "foo", "more" => "things", "str_baz" => 7}, at ["a"].\
             """
    end

    test "validate/3 with [fail: :early] invalid.structure",
         %{schema: schema, invalid: %{structure: data}} do
      opts = [fail: :early]

      assert {:error, error} = validate(schema, data, opts)

      assert error == %ValidationError{
               message: nil,
               reason: %{
                 properties: %{
                   "a" => %{
                     maxProperties: 3,
                     value: %{
                       "bar" => 9,
                       "foo" => "foo",
                       "more" => "things",
                       "str_baz" => 7
                     }
                   },
                   "b" => %{maxItems: 3, value: [1, "2", "3", :next, 1]}
                 }
               }
             }

      assert Exception.message(error) == """
             Expected at most 3 properties, \
             got %{"bar" => 9, "foo" => "foo", "more" => "things", "str_baz" => 7}, at ["a"].
             Expected at most 3 items, got [1, "2", "3", :next, 1], at ["b"].\
             """
    end

    test "validate/3 with [fail: :finally] invalid.structure",
         %{schema: schema, invalid: %{structure: data}} do
      opts = [fail: :finally]

      assert {:error, error} = validate(schema, data, opts)

      assert error == %ValidationError{
               message: nil,
               reason: %{
                 properties: %{
                   "a" => [
                     %{
                       properties: %{
                         "foo" => %{type: "integer", value: "foo"},
                         "more" => %{additionalProperties: false},
                         "str_baz" => %{type: "string", value: 7}
                       }
                     },
                     %{
                       maxProperties: 3,
                       value: %{
                         "bar" => 9,
                         "foo" => "foo",
                         "more" => "things",
                         "str_baz" => 7
                       }
                     }
                   ],
                   "b" => [
                     %{
                       items: %{
                         1 => %{type: "integer", value: "2"},
                         2 => %{type: "integer", value: "3"},
                         3 => %{type: "integer", value: :next}
                       }
                     },
                     %{uniqueItems: true, value: [1, "2", "3", :next, 1]},
                     %{maxItems: 3, value: [1, "2", "3", :next, 1]}
                   ]
                 }
               }
             }

      assert Exception.message(error) == """
             Expected at most 3 properties, \
             got %{"bar" => 9, "foo" => "foo", "more" => "things", "str_baz" => 7}, at ["a"].
             Expected "integer", got "foo", at ["a", "foo"].
             Expected only defined properties, got key ["a", "more"].
             Expected "string", got 7, at ["a", "str_baz"].
             Expected at most 3 items, got [1, "2", "3", :next, 1], at ["b"].
             Expected unique items, got [1, "2", "3", :next, 1], at ["b"].
             Expected "integer", got "2", at ["b", 1].
             Expected "integer", got "3", at ["b", 2].
             Expected "integer", got :next, at ["b", 3].\
             """
    end
  end
end
