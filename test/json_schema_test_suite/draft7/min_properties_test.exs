defmodule JsonSchemaTestSuite.Draft7.MinPropertiesTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|minProperties validation| do
    setup do
      %{schema: JsonXema.new(%{"minProperties" => 1})}
    end

    test ~s|longer is valid|, %{schema: schema} do
      assert valid?(schema, %{"bar" => 2, "foo" => 1})
    end

    test ~s|exact length is valid|, %{schema: schema} do
      assert valid?(schema, %{"foo" => 1})
    end

    test ~s|too short is invalid|, %{schema: schema} do
      refute valid?(schema, %{})
    end

    test ~s|ignores arrays|, %{schema: schema} do
      assert valid?(schema, [])
    end

    test ~s|ignores strings|, %{schema: schema} do
      assert valid?(schema, "")
    end

    test ~s|ignores other non-objects|, %{schema: schema} do
      assert valid?(schema, 12)
    end
  end
end
