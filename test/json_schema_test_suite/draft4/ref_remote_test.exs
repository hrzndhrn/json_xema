defmodule JsonSchemaTestSuite.Draft4.RefRemoteTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|remote ref| do
    setup do
      %{schema: JsonXema.new(%{"$ref" => "http://localhost:1234/integer.json"})}
    end

    test ~s|remote ref valid|, %{schema: schema} do
      assert valid?(schema, 1)
    end

    test ~s|remote ref invalid|, %{schema: schema} do
      refute valid?(schema, "a")
    end
  end

  describe ~s|fragment within remote ref| do
    setup do
      %{schema: JsonXema.new(%{"$ref" => "http://localhost:1234/subSchemas.json#/integer"})}
    end

    test ~s|remote fragment valid|, %{schema: schema} do
      assert valid?(schema, 1)
    end

    test ~s|remote fragment invalid|, %{schema: schema} do
      refute valid?(schema, "a")
    end
  end

  describe ~s|ref within remote ref| do
    setup do
      %{schema: JsonXema.new(%{"$ref" => "http://localhost:1234/subSchemas.json#/refToInteger"})}
    end

    test ~s|ref within ref valid|, %{schema: schema} do
      assert valid?(schema, 1)
    end

    test ~s|ref within ref invalid|, %{schema: schema} do
      refute valid?(schema, "a")
    end
  end

  describe ~s|base URI change| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "id" => "http://localhost:1234/",
            "items" => %{"id" => "baseUriChange/", "items" => %{"$ref" => "folderInteger.json"}}
          })
      }
    end

    test ~s|base URI change ref valid|, %{schema: schema} do
      assert valid?(schema, [[1]])
    end

    test ~s|base URI change ref invalid|, %{schema: schema} do
      refute valid?(schema, [["a"]])
    end
  end

  describe ~s|base URI change - change folder| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "definitions" => %{
              "baz" => %{
                "id" => "baseUriChangeFolder/",
                "items" => %{"$ref" => "folderInteger.json"},
                "type" => "array"
              }
            },
            "id" => "http://localhost:1234/scope_change_defs1.json",
            "properties" => %{"list" => %{"$ref" => "#/definitions/baz"}},
            "type" => "object"
          })
      }
    end

    test ~s|number is valid|, %{schema: schema} do
      assert valid?(schema, %{"list" => [1]})
    end

    test ~s|string is invalid|, %{schema: schema} do
      refute valid?(schema, %{"list" => ["a"]})
    end
  end

  describe ~s|base URI change - change folder in subschema| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "definitions" => %{
              "baz" => %{
                "definitions" => %{
                  "bar" => %{"items" => %{"$ref" => "folderInteger.json"}, "type" => "array"}
                },
                "id" => "baseUriChangeFolderInSubschema/"
              }
            },
            "id" => "http://localhost:1234/scope_change_defs2.json",
            "properties" => %{"list" => %{"$ref" => "#/definitions/baz/definitions/bar"}},
            "type" => "object"
          })
      }
    end

    test ~s|number is valid|, %{schema: schema} do
      assert valid?(schema, %{"list" => [1]})
    end

    test ~s|string is invalid|, %{schema: schema} do
      refute valid?(schema, %{"list" => ["a"]})
    end
  end

  describe ~s|root ref in remote ref| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "id" => "http://localhost:1234/object",
            "properties" => %{"name" => %{"$ref" => "name.json#/definitions/orNull"}},
            "type" => "object"
          })
      }
    end

    test ~s|string is valid|, %{schema: schema} do
      assert valid?(schema, %{"name" => "foo"})
    end

    test ~s|null is valid|, %{schema: schema} do
      assert valid?(schema, %{"name" => nil})
    end

    test ~s|object is invalid|, %{schema: schema} do
      refute valid?(schema, %{"name" => %{"name" => nil}})
    end
  end
end
