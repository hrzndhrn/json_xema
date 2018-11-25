defmodule JsonXema.DataTest do
  use ExUnit.Case, async: true

  describe "custom data: " do
    test "additional data goes to the data map" do
      schema =
        JsonXema.new("""
        {
          "type": "object",
          "foo": 3
        }
        """)

      assert schema.content.data == %{foo: 3}
    end

    test "maps are copied" do
      schema =
        JsonXema.new("""
        {
          "type": "object",
          "foo": {
            "bar": 5
          }
        }
        """)

      assert schema.content.data.foo == %{"bar" => 5}
    end

    test "can contain schemas" do
      schema =
        JsonXema.new("""
        {
          "type": "string",
          "foo": {
            "type": "integer"
          }
        }
        """)

      assert schema.content.data.foo ==
               JsonXema.new(~s({"type": "integer"})).content

      schema =
        JsonXema.new("""
        {
          "type": "integer",
          "foo": {
            "min_items": 5
          }
        }
        """)

      assert schema.content.data.foo ==
               JsonXema.new(~s({"min_items": 5})).content
    end

    test "data goes into data" do
      schema =
        JsonXema.new("""
        {
          "type": "object",
          "data": 3
        }
        """)

      assert schema.content.data == %{data: 3}
    end
  end
end
