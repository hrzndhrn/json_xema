defmodule Draft6.DefaultTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [is_valid?: 2]

  describe "invalid type for default" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"properties":{"foo":{"default":[],"type":"integer"}}} )
          )
      }
    end

    test "valid when property is specified", %{schema: schema} do
      data = %{foo: 13}
      assert is_valid?(schema, data)
    end

    test "still valid when the invalid default is used", %{schema: schema} do
      data = %{}
      assert is_valid?(schema, data)
    end
  end

  describe "invalid string value for default" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"properties":{"bar":{"default":"bad","minLength":4,"type":"string"}}} )
          )
      }
    end

    test "valid when property is specified", %{schema: schema} do
      data = %{bar: "good"}
      assert is_valid?(schema, data)
    end

    test "still valid when the invalid default is used", %{schema: schema} do
      data = %{}
      assert is_valid?(schema, data)
    end
  end
end
