defmodule JsonSchemaTestSuite.Draft4.AllOfTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|allOf| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "allOf" => [
              %{"properties" => %{"bar" => %{"type" => "integer"}}, "required" => ["bar"]},
              %{"properties" => %{"foo" => %{"type" => "string"}}, "required" => ["foo"]}
            ]
          })
      }
    end

    test ~s|allOf|, %{schema: schema} do
      assert valid?(schema, %{"bar" => 2, "foo" => "baz"})
    end

    test ~s|mismatch second|, %{schema: schema} do
      refute valid?(schema, %{"foo" => "baz"})
    end

    test ~s|mismatch first|, %{schema: schema} do
      refute valid?(schema, %{"bar" => 2})
    end

    test ~s|wrong type|, %{schema: schema} do
      refute valid?(schema, %{"bar" => "quux", "foo" => "baz"})
    end
  end

  describe ~s|allOf with base schema| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "allOf" => [
              %{"properties" => %{"foo" => %{"type" => "string"}}, "required" => ["foo"]},
              %{"properties" => %{"baz" => %{"type" => "null"}}, "required" => ["baz"]}
            ],
            "properties" => %{"bar" => %{"type" => "integer"}},
            "required" => ["bar"]
          })
      }
    end

    test ~s|valid|, %{schema: schema} do
      assert valid?(schema, %{"bar" => 2, "baz" => nil, "foo" => "quux"})
    end

    test ~s|mismatch base schema|, %{schema: schema} do
      refute valid?(schema, %{"baz" => nil, "foo" => "quux"})
    end

    test ~s|mismatch first allOf|, %{schema: schema} do
      refute valid?(schema, %{"bar" => 2, "baz" => nil})
    end

    test ~s|mismatch second allOf|, %{schema: schema} do
      refute valid?(schema, %{"bar" => 2, "foo" => "quux"})
    end

    test ~s|mismatch both|, %{schema: schema} do
      refute valid?(schema, %{"bar" => 2})
    end
  end

  describe ~s|allOf simple types| do
    setup do
      %{schema: JsonXema.new(%{"allOf" => [%{"maximum" => 30}, %{"minimum" => 20}]})}
    end

    test ~s|valid|, %{schema: schema} do
      assert valid?(schema, 25)
    end

    test ~s|mismatch one|, %{schema: schema} do
      refute valid?(schema, 35)
    end
  end

  describe ~s|allOf with one empty schema| do
    setup do
      %{schema: JsonXema.new(%{"allOf" => [%{}]})}
    end

    test ~s|any data is valid|, %{schema: schema} do
      assert valid?(schema, 1)
    end
  end

  describe ~s|allOf with two empty schemas| do
    setup do
      %{schema: JsonXema.new(%{"allOf" => [%{}, %{}]})}
    end

    test ~s|any data is valid|, %{schema: schema} do
      assert valid?(schema, 1)
    end
  end

  describe ~s|allOf with the first empty schema| do
    setup do
      %{schema: JsonXema.new(%{"allOf" => [%{}, %{"type" => "number"}]})}
    end

    test ~s|number is valid|, %{schema: schema} do
      assert valid?(schema, 1)
    end

    test ~s|string is invalid|, %{schema: schema} do
      refute valid?(schema, "foo")
    end
  end

  describe ~s|allOf with the last empty schema| do
    setup do
      %{schema: JsonXema.new(%{"allOf" => [%{"type" => "number"}, %{}]})}
    end

    test ~s|number is valid|, %{schema: schema} do
      assert valid?(schema, 1)
    end

    test ~s|string is invalid|, %{schema: schema} do
      refute valid?(schema, "foo")
    end
  end

  describe ~s|nested allOf, to check validation semantics| do
    setup do
      %{schema: JsonXema.new(%{"allOf" => [%{"allOf" => [%{"type" => "null"}]}]})}
    end

    test ~s|null is valid|, %{schema: schema} do
      assert valid?(schema, nil)
    end

    test ~s|anything non-null is invalid|, %{schema: schema} do
      refute valid?(schema, 123)
    end
  end

  describe ~s|allOf combined with anyOf, oneOf| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "allOf" => [%{"multipleOf" => 2}],
            "anyOf" => [%{"multipleOf" => 3}],
            "oneOf" => [%{"multipleOf" => 5}]
          })
      }
    end

    test ~s|allOf: false, anyOf: false, oneOf: false|, %{schema: schema} do
      refute valid?(schema, 1)
    end

    test ~s|allOf: false, anyOf: false, oneOf: true|, %{schema: schema} do
      refute valid?(schema, 5)
    end

    test ~s|allOf: false, anyOf: true, oneOf: false|, %{schema: schema} do
      refute valid?(schema, 3)
    end

    test ~s|allOf: false, anyOf: true, oneOf: true|, %{schema: schema} do
      refute valid?(schema, 15)
    end

    test ~s|allOf: true, anyOf: false, oneOf: false|, %{schema: schema} do
      refute valid?(schema, 2)
    end

    test ~s|allOf: true, anyOf: false, oneOf: true|, %{schema: schema} do
      refute valid?(schema, 10)
    end

    test ~s|allOf: true, anyOf: true, oneOf: false|, %{schema: schema} do
      refute valid?(schema, 6)
    end

    test ~s|allOf: true, anyOf: true, oneOf: true|, %{schema: schema} do
      assert valid?(schema, 30)
    end
  end
end
