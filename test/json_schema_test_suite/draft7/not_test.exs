defmodule JsonSchemaTestSuite.Draft7.NotTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|not| do
    setup do
      %{schema: JsonXema.new(%{"not" => %{"type" => "integer"}})}
    end

    test ~s|allowed|, %{schema: schema} do
      assert valid?(schema, "foo")
    end

    test ~s|disallowed|, %{schema: schema} do
      refute valid?(schema, 1)
    end
  end

  describe ~s|not multiple types| do
    setup do
      %{schema: JsonXema.new(%{"not" => %{"type" => ["integer", "boolean"]}})}
    end

    test ~s|valid|, %{schema: schema} do
      assert valid?(schema, "foo")
    end

    test ~s|mismatch|, %{schema: schema} do
      refute valid?(schema, 1)
    end

    test ~s|other mismatch|, %{schema: schema} do
      refute valid?(schema, true)
    end
  end

  describe ~s|not more complex schema| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "not" => %{"properties" => %{"foo" => %{"type" => "string"}}, "type" => "object"}
          })
      }
    end

    test ~s|match|, %{schema: schema} do
      assert valid?(schema, 1)
    end

    test ~s|other match|, %{schema: schema} do
      assert valid?(schema, %{"foo" => 1})
    end

    test ~s|mismatch|, %{schema: schema} do
      refute valid?(schema, %{"foo" => "bar"})
    end
  end

  describe ~s|forbidden property| do
    setup do
      %{schema: JsonXema.new(%{"properties" => %{"foo" => %{"not" => %{}}}})}
    end

    test ~s|property present|, %{schema: schema} do
      refute valid?(schema, %{"bar" => 2, "foo" => 1})
    end

    test ~s|property absent|, %{schema: schema} do
      assert valid?(schema, %{"bar" => 1, "baz" => 2})
    end
  end

  describe ~s|not with boolean schema true| do
    setup do
      %{schema: JsonXema.new(%{"not" => true})}
    end

    test ~s|any value is invalid|, %{schema: schema} do
      refute valid?(schema, "foo")
    end
  end

  describe ~s|not with boolean schema false| do
    setup do
      %{schema: JsonXema.new(%{"not" => false})}
    end

    test ~s|any value is valid|, %{schema: schema} do
      assert valid?(schema, "foo")
    end
  end
end
