defmodule JsonXema.RefRemoteTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  alias Jason.DecodeError
  alias Xema.SchemaError

  test "http server" do
    assert %{body: body} =
             HTTPoison.get!("http://localhost:1234/folder/folderInteger.json")

    assert body == File.read!("test/support/remote/folder/folderInteger.json")
  end

  describe "invalid remote ref: " do
    test "invalid json" do
      expected = "unexpected byte at position 0: 0x41 ('A')"

      assert_raise DecodeError, expected, fn ->
        ~s|{"$ref": "http://localhost:1234/invalid.json"}|
        |> Jason.decode!()
        |> JsonXema.new()
      end
    end

    test "404" do
      expected =
        "Remote schema 'http://localhost:1234/not-found.json' not found."

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
      assert JsonXema.validate(schema, 1) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert JsonXema.validate(schema, "1") ==
               {:error, %{type: "integer", value: "1"}}
    end
  end

  describe "fragment within remote ref" do
    setup do
      %{
        schema:
          """
            {
              "$ref": "http://localhost:1234/subSchemas.json#/integer"
            }
          """
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 1) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, "1") == {:error, %{type: "integer", value: "1"}}
    end
  end

  describe "ref within remote ref" do
    setup do
      %{
        schema:
          """
          {
            "$ref":
            "http://localhost:1234/subSchemas.json#/refToInteger"
          }
          """
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, 1) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, "1") == {:error, %{type: "integer", value: "1"}}
    end
  end

  describe "base URI change - change folder" do
    setup do
      %{
        schema:
          """
            {
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
            }
          """
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, %{"list" => [1]}) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, %{"list" => ["1"]}) ==
               {:error,
                %{
                  properties: %{
                    "list" => %{items: [{0, %{type: "integer", value: "1"}}]}
                  }
                }}
    end
  end

  describe "root ref in remote ref" do
    setup do
      %{
        schema:
          """
            {
              "type": "object",
              "id": "http://localhost:1234/object",
              "properties": {
                "name": {
                  "$ref": "name.json#/definitions/orNull"
                }
              }
            }
          """
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, %{"name" => "foo"}) == :ok
      assert validate(schema, %{"name" => nil}) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, %{"name" => 1}) ==
               {:error,
                %{
                  properties: %{
                    "name" => %{
                      anyOf: [
                        %{type: "null", value: 1},
                        %{type: "string", value: 1}
                      ],
                      value: 1
                    }
                  }
                }}
    end
  end

  describe "root ref in remote ref (id without path)" do
    setup do
      %{
        schema:
          """
            {
              "type": "object",
              "id": "http://localhost:1234",
              "properties": {
                "name": {
                  "$ref": "name.json#/definitions/orNull"
                }
              }
            }
          """
          |> Jason.decode!()
          |> JsonXema.new()
      }
    end

    test "validate/2 with a valid value", %{schema: schema} do
      assert validate(schema, %{"name" => "foo"}) == :ok
      assert validate(schema, %{"name" => nil}) == :ok
    end

    test "validate/2 with an invalid value", %{schema: schema} do
      assert validate(schema, %{"name" => 1}) ==
               {:error,
                %{
                  properties: %{
                    "name" => %{
                      anyOf: [
                        %{type: "null", value: 1},
                        %{type: "string", value: 1}
                      ],
                      value: 1
                    }
                  }
                }}
    end
  end
end
