defmodule Draft6.RequiredTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [is_valid?: 2]

  describe "required validation" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"properties":{"bar":{},"foo":{}},"required":["foo"]} )
          )
      }
    end

    test "present required property is valid", %{schema: schema} do
      data = %{foo: 1}
      assert is_valid?(schema, data)
    end

    test "non-present required property is invalid", %{schema: schema} do
      data = %{bar: 1}
      refute is_valid?(schema, data)
    end

    test "ignores arrays", %{schema: schema} do
      data = []
      assert is_valid?(schema, data)
    end

    test "ignores strings", %{schema: schema} do
      data = ""
      assert is_valid?(schema, data)
    end

    test "ignores other non-objects", %{schema: schema} do
      data = 12
      assert is_valid?(schema, data)
    end
  end

  describe "required default validation" do
    setup do
      %{schema: JsonXema.new(~s( {"properties":{"foo":{}}} ))}
    end

    test "not required by default", %{schema: schema} do
      data = %{}
      assert is_valid?(schema, data)
    end
  end

  describe "required with empty array" do
    setup do
      %{schema: JsonXema.new(~s( {"properties":{"foo":{}},"required":[]} ))}
    end

    test "property not required", %{schema: schema} do
      data = %{}
      assert is_valid?(schema, data)
    end
  end
end
