defmodule Draft4.OneOfTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [is_valid?: 2]

  describe "oneOf" do
    setup do
      %{
        schema: JsonXema.new(~s( {"oneOf":[{"type":"integer"},{"minimum":2}]} ))
      }
    end

    test "first oneOf valid", %{schema: schema} do
      data = 1
      assert is_valid?(schema, data)
    end

    test "second oneOf valid", %{schema: schema} do
      data = 2.5
      assert is_valid?(schema, data)
    end

    test "both oneOf valid", %{schema: schema} do
      data = 3
      refute is_valid?(schema, data)
    end

    test "neither oneOf valid", %{schema: schema} do
      data = 1.5
      refute is_valid?(schema, data)
    end
  end

  describe "oneOf with base schema" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"oneOf":[{"minLength":2},{"maxLength":4}],"type":"string"} )
          )
      }
    end

    test "mismatch base schema", %{schema: schema} do
      data = 3
      refute is_valid?(schema, data)
    end

    test "one oneOf valid", %{schema: schema} do
      data = "foobar"
      assert is_valid?(schema, data)
    end

    test "both oneOf valid", %{schema: schema} do
      data = "foo"
      refute is_valid?(schema, data)
    end
  end

  describe "oneOf complex types" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"oneOf":[{"properties":{"bar":{"type":"integer"}},"required":["bar"]},{"properties":{"foo":{"type":"string"}},"required":["foo"]}]} )
          )
      }
    end

    test "first oneOf valid (complex)", %{schema: schema} do
      data = %{bar: 2}
      assert is_valid?(schema, data)
    end

    test "second oneOf valid (complex)", %{schema: schema} do
      data = %{foo: "baz"}
      assert is_valid?(schema, data)
    end

    test "both oneOf valid (complex)", %{schema: schema} do
      data = %{bar: 2, foo: "baz"}
      refute is_valid?(schema, data)
    end

    test "neither oneOf valid (complex)", %{schema: schema} do
      data = %{bar: "quux", foo: 2}
      refute is_valid?(schema, data)
    end
  end
end
