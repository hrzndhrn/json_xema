defmodule Draft6.RefTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [is_valid?: 2]

  describe "root pointer ref" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"additionalProperties":false,"properties":{"foo":{"$ref":"#"}}} )
          )
      }
    end

    test "match", %{schema: schema} do
      data = %{foo: false}
      assert is_valid?(schema, data)
    end

    test "recursive match", %{schema: schema} do
      data = %{foo: %{foo: false}}
      assert is_valid?(schema, data)
    end

    test "mismatch", %{schema: schema} do
      data = %{bar: false}
      refute is_valid?(schema, data)
    end

    test "recursive mismatch", %{schema: schema} do
      data = %{foo: %{bar: false}}
      refute is_valid?(schema, data)
    end
  end

  describe "relative pointer ref to object" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"properties":{"bar":{"$ref":"#/properties/foo"},"foo":{"type":"integer"}}} )
          )
      }
    end

    test "match", %{schema: schema} do
      data = %{bar: 3}
      assert is_valid?(schema, data)
    end

    test "mismatch", %{schema: schema} do
      data = %{bar: true}
      refute is_valid?(schema, data)
    end
  end

  describe "relative pointer ref to array" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"items":[{"type":"integer"},{"$ref":"#/items/0"}]} )
          )
      }
    end

    test "match array", %{schema: schema} do
      data = [1, 2]
      assert is_valid?(schema, data)
    end

    test "mismatch array", %{schema: schema} do
      data = [1, "foo"]
      refute is_valid?(schema, data)
    end
  end

  describe "nested refs" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"$ref":"#/definitions/c","definitions":{"a":{"type":"integer"},"b":{"$ref":"#/definitions/a"},"c":{"$ref":"#/definitions/b"}}} )
          )
      }
    end

    test "nested ref valid", %{schema: schema} do
      data = 5
      assert is_valid?(schema, data)
    end

    test "nested ref invalid", %{schema: schema} do
      data = "a"
      refute is_valid?(schema, data)
    end
  end

  describe "property named $ref that is not a reference" do
    setup do
      %{schema: JsonXema.new(~s( {"properties":{"$ref":{"type":"string"}}} ))}
    end

    test "property named $ref valid", %{schema: schema} do
      data = %{"$ref": "a"}
      assert is_valid?(schema, data)
    end

    test "property named $ref invalid", %{schema: schema} do
      data = %{"$ref": 2}
      refute is_valid?(schema, data)
    end
  end

  describe "$ref to boolean schema true" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"$ref":"#/definitions/bool","definitions":{"bool":true}} )
          )
      }
    end

    test "any value is valid", %{schema: schema} do
      data = "foo"
      assert is_valid?(schema, data)
    end
  end

  describe "$ref to boolean schema false" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"$ref":"#/definitions/bool","definitions":{"bool":false}} )
          )
      }
    end

    test "any value is invalid", %{schema: schema} do
      data = "foo"
      refute is_valid?(schema, data)
    end
  end

  describe "Recursive references between schemas" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"$id":"http://localhost:1234/tree","definitions":{"node":{"$id":"http://localhost:1234/node","description":"node","properties":{"subtree":{"$ref":"tree"},"value":{"type":"number"}},"required":["value"],"type":"object"}},"description":"tree of nodes","properties":{"meta":{"type":"string"},"nodes":{"items":{"$ref":"node"},"type":"array"}},"required":["meta","nodes"],"type":"object"} )
          )
      }
    end

    test "valid tree", %{schema: schema} do
      data = %{
        meta: "root",
        nodes: [
          %{
            subtree: %{meta: "child", nodes: [%{value: 1.1}, %{value: 1.2}]},
            value: 1
          },
          %{
            subtree: %{meta: "child", nodes: [%{value: 2.1}, %{value: 2.2}]},
            value: 2
          }
        ]
      }

      assert is_valid?(schema, data)
    end

    test "invalid tree", %{schema: schema} do
      data = %{
        meta: "root",
        nodes: [
          %{
            subtree: %{
              meta: "child",
              nodes: [%{value: "string is invalid"}, %{value: 1.2}]
            },
            value: 1
          },
          %{
            subtree: %{meta: "child", nodes: [%{value: 2.1}, %{value: 2.2}]},
            value: 2
          }
        ]
      }

      refute is_valid?(schema, data)
    end
  end
end
