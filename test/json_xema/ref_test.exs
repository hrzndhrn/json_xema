defmodule JsonXema.RefTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  alias JsonXema.ValidationError
  alias Xema.Schema

  describe "schema with root pointer" do
    setup do
      %{
        schema:
          ~s({
            "properties": {
              "foo": {"$ref": "#"}
            },
            "additionalProperties": false
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with valid data", %{schema: schema} do
      assert validate(schema, %{"foo" => 1}) == :ok
    end

    test "validate/2 with invalid data", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"bar" => 1})

      assert error == %ValidationError{
               reason: %{properties: %{"bar" => %{additionalProperties: false}}}
             }
    end

    test "validate/2 with recursive valid data", %{schema: schema} do
      assert validate(schema, %{"foo" => %{"foo" => %{"foo" => 3}}}) == :ok
    end

    test "validate/2 with recursive invalid data", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"foo" => %{"foo" => %{"bar" => 3}}})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "foo" => %{
                     properties: %{
                       "foo" => %{
                         properties: %{"bar" => %{additionalProperties: false}}
                       }
                     }
                   }
                 }
               }
             }
    end
  end

  describe "schema with a ref to property" do
    setup do
      %{
        schema:
          ~s({
            "properties": {
              "foo": {"type": "integer"},
              "bar": {"$ref": "#/properties/foo"}
            }
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with valid data", %{schema: schema} do
      assert validate(schema, %{"foo" => 42}) == :ok
      assert validate(schema, %{"bar" => 42}) == :ok
      assert validate(schema, %{"foo" => 21, "bar" => 42}) == :ok
    end

    test "validate/2 with invalid data", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"foo" => "42"})

      assert error == %ValidationError{
               reason: %{properties: %{"foo" => %{type: "integer", value: "42"}}}
             }

      assert {:error, error} = validate(schema, %{"bar" => "42"})

      assert error == %ValidationError{
               reason: %{properties: %{"bar" => %{type: "integer", value: "42"}}}
             }

      assert {:error, error} = validate(schema, %{"foo" => "21", "bar" => "42"})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "bar" => %{type: "integer", value: "42"},
                   "foo" => %{type: "integer", value: "21"}
                 }
               }
             }
    end
  end

  describe "schema with ref and definitions" do
    setup do
      %{
        schema:
          ~s({
            "properties": {
              "foo": {"$ref": "#/definitions/pos"},
              "bar": {"$ref": "#/definitions/neg"}
            },
            "definitions": {
              "pos": {"type": "integer", "minimum": 0},
              "neg": {"type": "integer", "maximum": 0}
            }
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "schema", %{schema: schema} do
      assert schema == %JsonXema{
               refs: %{},
               schema: %Schema{
                 definitions: %{
                   "neg" => %Schema{maximum: 0, type: :integer},
                   "pos" => %Schema{minimum: 0, type: :integer}
                 },
                 properties: %{
                   "bar" => %Schema{maximum: 0, type: :integer},
                   "foo" => %Schema{minimum: 0, type: :integer}
                 }
               }
             }
    end

    test "validate/2 with valid values", %{schema: schema} do
      assert validate(schema, %{"foo" => 5, "bar" => -1}) == :ok
    end

    test "validate/2 with invalid values", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"foo" => -1, "bar" => 1})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "bar" => %{maximum: 0, value: 1},
                   "foo" => %{minimum: 0, value: -1}
                 }
               }
             }
    end
  end

  describe "schema with ref chain" do
    setup do
      %{
        schema:
          ~s({
            "properties": {
              "foo": {"$ref": "#/definitions/bar"}
            },
            "definitions": {
              "bar": {"$ref": "#/definitions/pos"},
              "pos": {"type": "integer", "minimum": 0}
            }
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with valid value", %{schema: schema} do
      assert validate(schema, %{"foo" => 42}) == :ok
    end

    test "validate/2 with invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"foo" => -21})

      assert error == %ValidationError{
               reason: %{properties: %{"foo" => %{minimum: 0, value: -21}}}
             }
    end
  end

  describe "schema with ref as keyword" do
    setup do
      %{
        schema:
          ~s({
            "$ref": "#/definitions/pos",
            "definitions": {
              "pos": {"type": "integer", "minimum": 0}
            }
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with valid value", %{schema: schema} do
      assert validate(schema, 42) == :ok
    end

    test "validate/2 with invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, -42)
      assert error == %ValidationError{reason: %{minimum: 0, value: -42}}
    end
  end

  describe "schema with ref to id" do
    setup do
      %{
        schema:
          ~s({
            "id": "http://foo.com",
            "$ref": "pos",
            "definitions": {
              "pos": {
                "type": "integer",
                "minimum": 0,
                "id": "http://foo.com/pos"
              }
            }
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with valid value", %{schema: schema} do
      assert validate(schema, 42) == :ok
    end

    test "validate/2 with invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, -42)
      assert error == %ValidationError{reason: %{minimum: 0, value: -42}}
    end
  end

  describe "schema with ref to a list item" do
    setup do
      %{
        schema:
          ~s({
            "items": [
              {"type": "integer"},
              {"$ref": "#/items/0"},
              {"$ref": "#/items/1"}
            ]
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with valid value", %{schema: schema} do
      assert validate(schema, [1, 2]) == :ok
      assert validate(schema, [1, 2, 3]) == :ok
    end

    test "validate/2 with invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, [1, "2"])
      assert error == %ValidationError{reason: %{items: %{1 => %{type: "integer", value: "2"}}}}

      assert {:error, error} = validate(schema, [1, 2, "3"])
      assert error == %ValidationError{reason: %{items: %{2 => %{type: "integer", value: "3"}}}}
    end
  end

  describe "schema with escaped refs" do
    setup do
      %{
        schema:
          ~s({
            "definitions": {
              "tilda~field": {"type": "integer"},
              "slash/field": {"type": "integer"},
              "percent%field": {"type": "integer"}
            },
            "properties": {
              "tilda_1": {"$ref": "#/definitions/tilda~field"},
              "tilda_2": {"$ref": "#/definitions/tilda~0field"},
              "tilda_3": {"$ref": "#/definitions/tilda%7Efield"},
              "percent": {"$ref": "#/definitions/percent%25field"},
              "slash_1": {"$ref": "#/definitions/slash~1field"},
              "slash_2": {"$ref": "#/definitions/slash%2Ffield"}
            }
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 tilda_1 with valid value", %{schema: schema} do
      assert validate(schema, %{tilda_1: 1}) == :ok
    end

    test "validate/2 tilda_1 with invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"tilda_1" => "1"})

      assert error == %ValidationError{
               reason: %{properties: %{"tilda_1" => %{type: "integer", value: "1"}}}
             }
    end

    test "validate/2 tilda_2 with valid value", %{schema: schema} do
      assert validate(schema, %{"tilda_2" => 1}) == :ok
    end

    test "validate/2 tilda_3 with valid value", %{schema: schema} do
      assert validate(schema, %{"tilda_3" => 1}) == :ok
    end

    test "validate/2 percent with valid value", %{schema: schema} do
      assert validate(schema, %{"percent" => 1}) == :ok
    end

    test "validate/2 slash_1 with valid value", %{schema: schema} do
      assert validate(schema, %{"slash_1" => 1}) == :ok
    end

    test "validate/2 slash_2 with valid value", %{schema: schema} do
      assert validate(schema, %{"slash_2" => 1}) == :ok
    end

    test "validate/2 with invalid values", %{schema: schema} do
      assert {:error, error} =
               validate(schema, %{
                 "tilda_1" => "1",
                 "tilda_2" => "1",
                 "tilda_3" => "1",
                 "slash_1" => "1",
                 "slash_2" => "1",
                 "percent" => "1"
               })

      assert error ==
               %ValidationError{
                 reason: %{
                   properties: %{
                     "percent" => %{type: "integer", value: "1"},
                     "slash_1" => %{type: "integer", value: "1"},
                     "slash_2" => %{type: "integer", value: "1"},
                     "tilda_1" => %{type: "integer", value: "1"},
                     "tilda_2" => %{type: "integer", value: "1"},
                     "tilda_3" => %{type: "integer", value: "1"}
                   }
                 }
               }
    end
  end

  describe "schema with recursive refs" do
    setup do
      %{
        schema:
          ~s({
            "type": "object",
            "id": "http://localhost:1234/tree",
            "description": "tree of nodes",
            "properties": {
              "meta": {"type": "string"},
              "nodes": {
                "type": "array",
                "items": {"$ref": "node"}
              }
            },
            "required": ["meta", "nodes"],
            "definitions": {
              "node": {
                "type": "object",
                "id": "http://localhost:1234/node",
                "description": "node",
                "properties": {
                  "value": {"type": "number"},
                  "subtree": {"$ref": "tree"}
                },
                "required": ["value"]
              }
            }
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid root", %{schema: schema} do
      tree = %{
        "meta" => "root",
        "nodes" => []
      }

      assert validate(schema, tree) == :ok
    end

    test "ids", %{schema: schema} do
      assert Map.keys(schema.refs) == [
               "http://localhost:1234/node",
               "http://localhost:1234/tree"
             ]
    end

    test "validate/2 with a valid tree", %{schema: schema} do
      tree = %{
        "meta" => "root",
        "nodes" => [
          %{
            "value" => 5,
            "subtree" => %{
              "meta" => "sub",
              "nodes" => [
                %{
                  "value" => 42
                },
                %{
                  "value" => 21,
                  "subtree" => %{
                    "meta" => "foo",
                    "value" => 667,
                    "nodes" => []
                  }
                }
              ]
            }
          }
        ]
      }

      assert validate(schema, tree) == :ok
    end

    test "validate/2 with a missing nodes property", %{schema: schema} do
      tree = %{
        "meta" => "root",
        "nodes" => [
          %{
            "value" => 5,
            "subtree" => %{
              "meta" => "sub",
              "nodes" => [
                %{
                  "value" => 42
                },
                %{
                  "value" => 21,
                  "subtree" => %{
                    "meta" => "foo",
                    "value" => 667
                  }
                }
              ]
            }
          }
        ]
      }

      assert {:error, error} = validate(schema, tree)

      assert error ==
               %ValidationError{
                 reason: %{
                   properties: %{
                     "nodes" => %{
                       items: %{
                         0 => %{
                           properties: %{
                             "subtree" => %{
                               properties: %{
                                 "nodes" => %{
                                   items: %{
                                     1 => %{
                                       properties: %{
                                         "subtree" => %{required: ["nodes"]}
                                       }
                                     }
                                   }
                                 }
                               }
                             }
                           }
                         }
                       }
                     }
                   }
                 }
               }
    end
  end

  describe "schema with ref path with none-keyword" do
    setup do
      schema =
        """
        {
          "definitions": {
            "common": {
              "foo": {
                "type": "number",
                "minimum": 0,
                "maximum": 100
              }
            }
          },
          "user": {
            "properties": {
              "id": {
                "$ref": "#/definitions/common/foo"
              }
            }
          }
        }
        """
        |> Jason.decode!()
        |> JsonXema.new()

      %{schema: schema}
    end

    test "validate/2 with a valid data", %{schema: schema} do
      assert validate(schema, %{"user" => %{"id" => 555}}) == :ok
    end
  end
end
