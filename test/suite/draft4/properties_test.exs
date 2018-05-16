defmodule Draft4.PropertiesTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [is_valid?: 2]

  describe "object properties validation" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"properties":{"bar":{"type":"string"},"foo":{"type":"integer"}}} )
          )
      }
    end

    test "both properties present and valid is valid", %{schema: schema} do
      data = %{bar: "baz", foo: 1}
      assert is_valid?(schema, data)
    end

    test "one property invalid is invalid", %{schema: schema} do
      data = %{bar: %{}, foo: 1}
      refute is_valid?(schema, data)
    end

    test "both properties invalid is invalid", %{schema: schema} do
      data = %{bar: %{}, foo: []}
      refute is_valid?(schema, data)
    end

    test "doesn't invalidate other properties", %{schema: schema} do
      data = %{quux: []}
      assert is_valid?(schema, data)
    end

    test "ignores arrays", %{schema: schema} do
      data = []
      assert is_valid?(schema, data)
    end

    test "ignores other non-objects", %{schema: schema} do
      data = 12
      assert is_valid?(schema, data)
    end
  end

  describe "properties, patternProperties, additionalProperties interaction" do
    setup do
      %{
        schema:
          JsonXema.new(
            ~s( {"additionalProperties":{"type":"integer"},"patternProperties":{"f.o":{"minItems":2}},"properties":{"bar":{"type":"array"},"foo":{"maxItems":3,"type":"array"}}} )
          )
      }
    end

    test "property validates property", %{schema: schema} do
      data = %{foo: [1, 2]}
      assert is_valid?(schema, data)
    end

    test "property invalidates property", %{schema: schema} do
      data = %{foo: [1, 2, 3, 4]}
      refute is_valid?(schema, data)
    end

    test "patternProperty invalidates property", %{schema: schema} do
      data = %{foo: []}
      refute is_valid?(schema, data)
    end

    test "patternProperty validates nonproperty", %{schema: schema} do
      data = %{fxo: [1, 2]}
      assert is_valid?(schema, data)
    end

    test "patternProperty invalidates nonproperty", %{schema: schema} do
      data = %{fxo: []}
      refute is_valid?(schema, data)
    end

    test "additionalProperty ignores property", %{schema: schema} do
      data = %{bar: []}
      assert is_valid?(schema, data)
    end

    test "additionalProperty validates others", %{schema: schema} do
      data = %{quux: 3}
      assert is_valid?(schema, data)
    end

    test "additionalProperty invalidates others", %{schema: schema} do
      data = %{quux: "foo"}
      refute is_valid?(schema, data)
    end
  end
end
