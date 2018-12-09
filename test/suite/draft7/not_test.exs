defmodule Draft7.NotTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "not" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "not": {
            "type": "integer"
          }
        }
      ))}
    end

    test "allowed", %{schema: schema} do
      data = "foo"
      assert valid?(schema, data)
    end

    test "disallowed", %{schema: schema} do
      data = 1
      refute valid?(schema, data)
    end
  end

  describe "not multiple types" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "not": {
            "type": [
              "integer",
              "boolean"
            ]
          }
        }
      ))}
    end

    test "valid", %{schema: schema} do
      data = "foo"
      assert valid?(schema, data)
    end

    test "mismatch", %{schema: schema} do
      data = 1
      refute valid?(schema, data)
    end

    test "other mismatch", %{schema: schema} do
      data = true
      refute valid?(schema, data)
    end
  end

  describe "not more complex schema" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "not": {
            "properties": {
              "foo": {
                "type": "string"
              }
            },
            "type": "object"
          }
        }
      ))}
    end

    test "match", %{schema: schema} do
      data = 1
      assert valid?(schema, data)
    end

    test "other match", %{schema: schema} do
      data = %{"foo" => 1}
      assert valid?(schema, data)
    end

    test "mismatch", %{schema: schema} do
      data = %{"foo" => "bar"}
      refute valid?(schema, data)
    end
  end

  describe "forbidden property" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "properties": {
            "foo": {
              "not": {}
            }
          }
        }
      ))}
    end

    test "property present", %{schema: schema} do
      data = %{"bar" => 2, "foo" => 1}
      refute valid?(schema, data)
    end

    test "property absent", %{schema: schema} do
      data = %{"bar" => 1, "baz" => 2}
      assert valid?(schema, data)
    end
  end

  describe "not with boolean schema true" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "not": true
        }
      ))}
    end

    test "any value is invalid", %{schema: schema} do
      data = "foo"
      refute valid?(schema, data)
    end
  end

  describe "not with boolean schema false" do
    setup do
      %{schema: JsonXema.new(~s(
        {
          "not": false
        }
      ))}
    end

    test "any value is valid", %{schema: schema} do
      data = "foo"
      assert valid?(schema, data)
    end
  end
end
