defmodule JsonSchemaTestSuite.Draft6.AnyOfTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|anyOf| do
    setup do
      %{schema: JsonXema.new(%{"anyOf" => [%{"type" => "integer"}, %{"minimum" => 2}]})}
    end

    test ~s|first anyOf valid|, %{schema: schema} do
      assert valid?(schema, 1)
    end

    test ~s|second anyOf valid|, %{schema: schema} do
      assert valid?(schema, 2.5)
    end

    test ~s|both anyOf valid|, %{schema: schema} do
      assert valid?(schema, 3)
    end

    test ~s|neither anyOf valid|, %{schema: schema} do
      refute valid?(schema, 1.5)
    end
  end

  describe ~s|anyOf with base schema| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "anyOf" => [%{"maxLength" => 2}, %{"minLength" => 4}],
            "type" => "string"
          })
      }
    end

    test ~s|mismatch base schema|, %{schema: schema} do
      refute valid?(schema, 3)
    end

    test ~s|one anyOf valid|, %{schema: schema} do
      assert valid?(schema, "foobar")
    end

    test ~s|both anyOf invalid|, %{schema: schema} do
      refute valid?(schema, "foo")
    end
  end

  describe ~s|anyOf with boolean schemas, all true| do
    setup do
      %{schema: JsonXema.new(%{"anyOf" => [true, true]})}
    end

    test ~s|any value is valid|, %{schema: schema} do
      assert valid?(schema, "foo")
    end
  end

  describe ~s|anyOf with boolean schemas, some true| do
    setup do
      %{schema: JsonXema.new(%{"anyOf" => [true, false]})}
    end

    test ~s|any value is valid|, %{schema: schema} do
      assert valid?(schema, "foo")
    end
  end

  describe ~s|anyOf with boolean schemas, all false| do
    setup do
      %{schema: JsonXema.new(%{"anyOf" => [false, false]})}
    end

    test ~s|any value is invalid|, %{schema: schema} do
      refute valid?(schema, "foo")
    end
  end

  describe ~s|anyOf complex types| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "anyOf" => [
              %{"properties" => %{"bar" => %{"type" => "integer"}}, "required" => ["bar"]},
              %{"properties" => %{"foo" => %{"type" => "string"}}, "required" => ["foo"]}
            ]
          })
      }
    end

    test ~s|first anyOf valid (complex)|, %{schema: schema} do
      assert valid?(schema, %{"bar" => 2})
    end

    test ~s|second anyOf valid (complex)|, %{schema: schema} do
      assert valid?(schema, %{"foo" => "baz"})
    end

    test ~s|both anyOf valid (complex)|, %{schema: schema} do
      assert valid?(schema, %{"bar" => 2, "foo" => "baz"})
    end

    test ~s|neither anyOf valid (complex)|, %{schema: schema} do
      refute valid?(schema, %{"bar" => "quux", "foo" => 2})
    end
  end

  describe ~s|anyOf with one empty schema| do
    setup do
      %{schema: JsonXema.new(%{"anyOf" => [%{"type" => "number"}, %{}]})}
    end

    test ~s|string is valid|, %{schema: schema} do
      assert valid?(schema, "foo")
    end

    test ~s|number is valid|, %{schema: schema} do
      assert valid?(schema, 123)
    end
  end

  describe ~s|nested anyOf, to check validation semantics| do
    setup do
      %{schema: JsonXema.new(%{"anyOf" => [%{"anyOf" => [%{"type" => "null"}]}]})}
    end

    test ~s|null is valid|, %{schema: schema} do
      assert valid?(schema, nil)
    end

    test ~s|anything non-null is invalid|, %{schema: schema} do
      refute valid?(schema, 123)
    end
  end

  describe ~s|nested anyOf, to check validation semantics (1)| do
    setup do
      %{schema: JsonXema.new(%{"anyOf" => [%{"anyOf" => [%{"type" => "null"}]}]})}
    end

    test ~s|null is valid|, %{schema: schema} do
      assert valid?(schema, nil)
    end

    test ~s|anything non-null is invalid|, %{schema: schema} do
      refute valid?(schema, 123)
    end
  end
end
