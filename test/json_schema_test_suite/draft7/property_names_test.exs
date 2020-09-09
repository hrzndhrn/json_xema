defmodule JsonSchemaTestSuite.Draft7.PropertyNamesTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|propertyNames validation| do
    setup do
      %{schema: JsonXema.new(%{"propertyNames" => %{"maxLength" => 3}})}
    end

    test ~s|all property names valid|, %{schema: schema} do
      assert valid?(schema, %{"f" => %{}, "foo" => %{}})
    end

    test ~s|some property names invalid|, %{schema: schema} do
      refute valid?(schema, %{"foo" => %{}, "foobar" => %{}})
    end

    test ~s|object without properties is valid|, %{schema: schema} do
      assert valid?(schema, %{})
    end

    test ~s|ignores arrays|, %{schema: schema} do
      assert valid?(schema, [1, 2, 3, 4])
    end

    test ~s|ignores strings|, %{schema: schema} do
      assert valid?(schema, "foobar")
    end

    test ~s|ignores other non-objects|, %{schema: schema} do
      assert valid?(schema, 12)
    end
  end

  describe ~s|propertyNames with boolean schema true| do
    setup do
      %{schema: JsonXema.new(%{"propertyNames" => true})}
    end

    test ~s|object with any properties is valid|, %{schema: schema} do
      assert valid?(schema, %{"foo" => 1})
    end

    test ~s|empty object is valid|, %{schema: schema} do
      assert valid?(schema, %{})
    end
  end

  describe ~s|propertyNames with boolean schema false| do
    setup do
      %{schema: JsonXema.new(%{"propertyNames" => false})}
    end

    test ~s|object with any properties is invalid|, %{schema: schema} do
      refute valid?(schema, %{"foo" => 1})
    end

    test ~s|empty object is valid|, %{schema: schema} do
      assert valid?(schema, %{})
    end
  end
end
