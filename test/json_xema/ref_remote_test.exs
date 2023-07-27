defmodule JsonXema.RefRemoteTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  alias Jason.DecodeError
  alias JsonXema.ValidationError
  alias Xema.Ref
  alias Xema.Schema
  alias Xema.SchemaError

  test "http server" do
    assert %{body: body} = HTTPoison.get!("http://localhost:1234/folder/folderInteger.json")

    assert body == File.read!("test/fixtures/remote/folder/folderInteger.json")
  end

  describe "invalid remote ref: " do
    test "invalid json" do
      expected = ~s|unexpected byte at position 0: 0x41 ("A")|

      assert_raise DecodeError, expected, fn ->
        ~s|{"$ref": "http://localhost:1234/invalid.json"}|
        |> Jason.decode!()
        |> JsonXema.new()
      end
    end

    test "404" do
      expected = "Remote schema 'http://localhost:1234/not-found.json' not found."

      assert_raise SchemaError, expected, fn ->
        ~s|{"$ref": "http://localhost:1234/not-found.json"}|
        |> Jason.decode!()
        |> JsonXema.new()
      end
    end
  end

  describe "remote ref" do
    setup do
      %{
        schema:
          ~s|{"$ref": "http://localhost:1234/integer.json"}|
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 1) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, "1")
      assert error == %ValidationError{reason: %{type: "integer", value: "1"}}
    end
  end

  describe "fragment within remote ref" do
    setup do
      %{
        schema:
          ~s({"$ref": "http://localhost:1234/subSchemas.json#/integer"})
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 1) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, "1")
      assert error == %ValidationError{reason: %{type: "integer", value: "1"}}
    end
  end

  describe "ref within remote ref" do
    setup do
      %{
        schema:
          ~s({"$ref": "http://localhost:1234/subSchemas.json#/refToInteger"})
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 1) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, "1")
      assert error == %ValidationError{reason: %{type: "integer", value: "1"}}
    end
  end

  describe "base URI change - change folder" do
    setup do
      %{
        schema:
          ~s({
            "type": "object",
            "id": "http://localhost:1234/scope_change_defs1.json",
            "properties": {
              "list": {
                "$ref": "#/definitions/baz"
              }
            },
            "definitions": {
              "baz": {
                "type": "array",
                "id": "folder/",
                "items": {
                  "$ref": "folderInteger.json"
                }
              }
            }
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, %{"list" => [1]}) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"list" => ["1"]})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "list" => %{items: %{0 => %{type: "integer", value: "1"}}}
                 }
               }
             }
    end
  end

  describe "root ref in remote ref" do
    setup do
      %{
        schema:
          ~s({
            "type": "object",
            "id": "http://localhost:1234/object",
            "properties": {
              "name": {
                "$ref": "name.json#/definitions/orNull"
              }
            }
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, %{"name" => "foo"}) == :ok
      assert validate(schema, %{"name" => nil}) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"name" => 1})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "name" => %{
                     anyOf: [
                       %{type: "null", value: 1},
                       %{type: "string", value: 1}
                     ],
                     value: 1
                   }
                 }
               }
             }
    end
  end

  describe "root ref in remote ref (id without path)" do
    setup do
      %{
        schema:
          ~s({
            "type": "object",
            "id": "http://localhost:1234",
            "properties": {
              "name": {
                "$ref": "name.json#/definitions/orNull"
              }
            }
          })
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, %{"name" => "foo"}) == :ok
      assert validate(schema, %{"name" => nil}) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert {:error, error} = validate(schema, %{"name" => 1})

      assert error == %ValidationError{
               reason: %{
                 properties: %{
                   "name" => %{
                     anyOf: [
                       %{type: "null", value: 1},
                       %{type: "string", value: 1}
                     ],
                     value: 1
                   }
                 }
               }
             }
    end
  end

  describe "file ref" do
    setup do
      %{
        schema:
          ~s({
            "type": "object",
            "properties": {
              "int": {"ref": "integer.json"}
            }
          })
          |> Jason.decode!()
          |> JsonXema.new(loader: Test.FileLoader)
      }
    end

    test "valid data", %{schema: schema} do
      assert validate(schema, %{"int" => 66})
    end
  end

  describe "file circular ref in sub schema [inline: false]" do
    setup do
      %{
        schema:
          ~s({"ref": "main.json"})
          |> Jason.decode!()
          |> JsonXema.new(loader: Test.FileLoader)
      }
    end

    test "check schema", %{schema: schema} do
      assert schema == %JsonXema{
               refs: %{
                 "#/definitions/self" => %Schema{
                   properties: %{
                     "a" => %Schema{type: :string},
                     "b" => %Schema{ref: %Ref{pointer: "#/definitions/self"}}
                   },
                   type: :map
                 }
               },
               schema: %Schema{
                 definitions: %{
                   "self" => %Schema{
                     properties: %{
                       "a" => %Schema{type: :string},
                       "b" => %Schema{ref: %Ref{pointer: "#/definitions/self"}}
                     },
                     type: :map
                   }
                 },
                 ref: %Ref{pointer: "#/definitions/self"},
                 schema: "http://json-schema.org/draft-04/schema#"
               }
             }
    end

    test "check with valid data", %{schema: schema} do
      assert JsonXema.valid?(schema, %{"a" => "a"}) == true
      assert JsonXema.valid?(schema, %{"a" => "a", "b" => %{"a" => "next"}}) == true
    end

    test "check with invalid data", %{schema: schema} do
      assert JsonXema.valid?(schema, %{"a" => 1}) == false
      assert JsonXema.valid?(schema, %{"a" => "a", "b" => %{"a" => :next}}) == false
    end
  end

  describe "file circular ref with ref" do
    setup do
      %{
        schema:
          ~s({"ref": "circular.json"})
          |> Jason.decode!()
          |> JsonXema.new(loader: Test.FileLoader)
      }
    end

    test "check schema", %{schema: schema} do
      assert schema ==
               %JsonXema{
                 refs: %{
                   "circular.json" => %JsonXema{
                     schema: %Schema{
                       properties: %{
                         "bar" => %Schema{type: :integer},
                         "foo" => %Schema{
                           ref: %Ref{
                             pointer: "circular.json",
                             uri: %URI{
                               authority: nil,
                               fragment: nil,
                               host: nil,
                               path: "circular.json",
                               port: nil,
                               query: nil,
                               scheme: nil,
                               userinfo: nil
                             }
                           }
                         }
                       },
                       type: :map
                     },
                     refs: %{}
                   }
                 },
                 schema: %Schema{
                   ref: %Ref{
                     pointer: "circular.json",
                     uri: %URI{
                       authority: nil,
                       fragment: nil,
                       host: nil,
                       path: "circular.json",
                       port: nil,
                       query: nil,
                       scheme: nil,
                       userinfo: nil
                     }
                   }
                 }
               }
    end

    test "validate/2 with valid data", %{schema: schema} do
      assert validate(schema, %{"foo" => %{"bar" => 1}, "bar" => 2}) == :ok
    end
  end

  describe "file ref with refs" do
    setup do
      %{
        schema:
          ~s({"ref": "obj_list_int.json"})
          |> Jason.decode!()
          |> JsonXema.new(loader: Test.FileLoader)
      }
    end

    test "check schema", %{schema: schema} do
      assert schema == %JsonXema{
               refs: %{},
               schema: %Schema{
                 properties: %{
                   "another_int" => %Schema{type: :integer},
                   "int" => %Schema{type: :integer},
                   "ints" => %Schema{items: %Schema{type: :integer}, type: :list}
                 },
                 type: :map
               }
             }
    end
  end

  describe "file ref with refs (inline: false)" do
    setup do
      %{
        schema:
          ~s({"ref": "obj_list_int.json"})
          |> Jason.decode!()
          |> JsonXema.new(loader: Test.FileLoader, inline: false)
      }
    end

    test "schema", %{schema: schema} do
      assert schema == %JsonXema{
               refs: %{
                 "int.json" => %JsonXema{
                   refs: %{},
                   schema: %Schema{type: :integer}
                 },
                 "list_int.json" => %JsonXema{
                   refs: %{},
                   schema: %Schema{
                     items: %Schema{
                       ref: %Ref{
                         pointer: "int.json",
                         uri: %URI{
                           authority: nil,
                           fragment: nil,
                           host: nil,
                           path: "int.json",
                           port: nil,
                           query: nil,
                           scheme: nil,
                           userinfo: nil
                         }
                       }
                     },
                     type: :list
                   }
                 },
                 "obj_list_int.json" => %JsonXema{
                   refs: %{},
                   schema: %Schema{
                     properties: %{
                       "another_int" => %Schema{
                         ref: %Ref{
                           pointer: "int.json",
                           uri: %URI{
                             authority: nil,
                             fragment: nil,
                             host: nil,
                             path: "int.json",
                             port: nil,
                             query: nil,
                             scheme: nil,
                             userinfo: nil
                           }
                         }
                       },
                       "int" => %Schema{
                         ref: %Ref{
                           pointer: "int.json",
                           uri: %URI{
                             authority: nil,
                             fragment: nil,
                             host: nil,
                             path: "int.json",
                             port: nil,
                             query: nil,
                             scheme: nil,
                             userinfo: nil
                           }
                         }
                       },
                       "ints" => %Schema{
                         ref: %Ref{
                           pointer: "list_int.json",
                           uri: %URI{
                             authority: nil,
                             fragment: nil,
                             host: nil,
                             path: "list_int.json",
                             port: nil,
                             query: nil,
                             scheme: nil,
                             userinfo: nil
                           }
                         }
                       }
                     },
                     type: :map
                   }
                 }
               },
               schema: %Schema{
                 ref: %Ref{
                   pointer: "obj_list_int.json",
                   uri: %URI{
                     authority: nil,
                     fragment: nil,
                     host: nil,
                     path: "obj_list_int.json",
                     port: nil,
                     query: nil,
                     scheme: nil,
                     userinfo: nil
                   }
                 }
               }
             }
    end
  end

  test "issue-173" do
    assert "test/fixtures/remote/issue-173/root.json"
           |> File.read!()
           |> Jason.decode!()
           |> JsonXema.new(loader: Test.FileLoader)
  end
end
