defmodule Draft6.RefRemoteTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "remote ref" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "$ref": "http://localhost:1234/integer.json"
        }
      ))}
    end

    test "remote ref valid", %{schema: schema} do
      data = 1
      assert valid?(schema, data)
    end

    test "remote ref invalid", %{schema: schema} do
      data = "a"
      refute valid?(schema, data)
    end
  end

  describe "fragment within remote ref" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "$ref": "http://localhost:1234/subSchemas.json#/integer"
        }
      ))}
    end

    test "remote fragment valid", %{schema: schema} do
      data = 1
      assert valid?(schema, data)
    end

    test "remote fragment invalid", %{schema: schema} do
      data = "a"
      refute valid?(schema, data)
    end
  end

  describe "ref within remote ref" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "$ref": "http://localhost:1234/subSchemas.json#/refToInteger"
        }
      ))}
    end

    test "ref within ref valid", %{schema: schema} do
      data = 1
      assert valid?(schema, data)
    end

    test "ref within ref invalid", %{schema: schema} do
      data = "a"
      refute valid?(schema, data)
    end
  end

  describe "base URI change" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "$id": "http://localhost:1234/",
          "items": {
            "$id": "folder/",
            "items": {
              "$ref": "folderInteger.json"
            }
          }
        }
      ))}
    end

    test "base URI change ref valid", %{schema: schema} do
      data = [[1]]
      assert valid?(schema, data)
    end

    test "base URI change ref invalid", %{schema: schema} do
      data = [["a"]]
      refute valid?(schema, data)
    end
  end

  describe "base URI change - change folder" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "$id": "http://localhost:1234/scope_change_defs1.json",
          "definitions": {
            "baz": {
              "$id": "folder/",
              "items": {
                "$ref": "folderInteger.json"
              },
              "type": "array"
            }
          },
          "properties": {
            "list": {
              "$ref": "#/definitions/baz"
            }
          },
          "type": "object"
        }
      ))}
    end

    test "number is valid", %{schema: schema} do
      data = %{"list" => [1]}
      assert valid?(schema, data)
    end

    test "string is invalid", %{schema: schema} do
      data = %{"list" => ["a"]}
      refute valid?(schema, data)
    end
  end

  describe "base URI change - change folder in subschema" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "$id": "http://localhost:1234/scope_change_defs2.json",
          "definitions": {
            "baz": {
              "$id": "folder/",
              "definitions": {
                "bar": {
                  "items": {
                    "$ref": "folderInteger.json"
                  },
                  "type": "array"
                }
              }
            }
          },
          "properties": {
            "list": {
              "$ref": "#/definitions/baz/definitions/bar"
            }
          },
          "type": "object"
        }
      ))}
    end

    test "number is valid", %{schema: schema} do
      data = %{"list" => [1]}
      assert valid?(schema, data)
    end

    test "string is invalid", %{schema: schema} do
      data = %{"list" => ["a"]}
      refute valid?(schema, data)
    end
  end

  describe "root ref in remote ref" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "$id": "http://localhost:1234/object",
          "properties": {
            "name": {
              "$ref": "name.json#/definitions/orNull"
            }
          },
          "type": "object"
        }
      ))}
    end

    test "string is valid", %{schema: schema} do
      data = %{"name" => "foo"}
      assert valid?(schema, data)
    end

    test "null is valid", %{schema: schema} do
      data = %{"name" => nil}
      assert valid?(schema, data)
    end

    test "object is invalid", %{schema: schema} do
      data = %{"name" => %{"name" => nil}}
      refute valid?(schema, data)
    end
  end
end
