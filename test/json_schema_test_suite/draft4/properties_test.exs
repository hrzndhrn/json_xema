defmodule JsonSchemaTestSuite.Draft4.PropertiesTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|object properties validation| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "properties" => %{"bar" => %{"type" => "string"}, "foo" => %{"type" => "integer"}}
          })
      }
    end

    test ~s|both properties present and valid is valid|, %{schema: schema} do
      assert valid?(schema, %{"bar" => "baz", "foo" => 1})
    end

    test ~s|one property invalid is invalid|, %{schema: schema} do
      refute valid?(schema, %{"bar" => %{}, "foo" => 1})
    end

    test ~s|both properties invalid is invalid|, %{schema: schema} do
      refute valid?(schema, %{"bar" => %{}, "foo" => []})
    end

    test ~s|doesn't invalidate other properties|, %{schema: schema} do
      assert valid?(schema, %{"quux" => []})
    end

    test ~s|ignores arrays|, %{schema: schema} do
      assert valid?(schema, [])
    end

    test ~s|ignores other non-objects|, %{schema: schema} do
      assert valid?(schema, 12)
    end
  end

  describe ~s|properties, patternProperties, additionalProperties interaction| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "additionalProperties" => %{"type" => "integer"},
            "patternProperties" => %{"f.o" => %{"minItems" => 2}},
            "properties" => %{
              "bar" => %{"type" => "array"},
              "foo" => %{"maxItems" => 3, "type" => "array"}
            }
          })
      }
    end

    test ~s|property validates property|, %{schema: schema} do
      assert valid?(schema, %{"foo" => [1, 2]})
    end

    test ~s|property invalidates property|, %{schema: schema} do
      refute valid?(schema, %{"foo" => [1, 2, 3, 4]})
    end

    test ~s|patternProperty invalidates property|, %{schema: schema} do
      refute valid?(schema, %{"foo" => []})
    end

    test ~s|patternProperty validates nonproperty|, %{schema: schema} do
      assert valid?(schema, %{"fxo" => [1, 2]})
    end

    test ~s|patternProperty invalidates nonproperty|, %{schema: schema} do
      refute valid?(schema, %{"fxo" => []})
    end

    test ~s|additionalProperty ignores property|, %{schema: schema} do
      assert valid?(schema, %{"bar" => []})
    end

    test ~s|additionalProperty validates others|, %{schema: schema} do
      assert valid?(schema, %{"quux" => 3})
    end

    test ~s|additionalProperty invalidates others|, %{schema: schema} do
      refute valid?(schema, %{"quux" => "foo"})
    end
  end

  describe ~s|properties with escaped characters| do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "properties" => %{
              "foo\tbar" => %{"type" => "number"},
              "foo\nbar" => %{"type" => "number"},
              "foo\fbar" => %{"type" => "number"},
              "foo\rbar" => %{"type" => "number"},
              "foo\"bar" => %{"type" => "number"},
              "foo\\bar" => %{"type" => "number"}
            }
          })
      }
    end

    test ~s|object with all numbers is valid|, %{schema: schema} do
      assert valid?(schema, %{
               "foo\tbar" => 1,
               "foo\nbar" => 1,
               "foo\fbar" => 1,
               "foo\rbar" => 1,
               "foo\"bar" => 1,
               "foo\\bar" => 1
             })
    end

    test ~s|object with strings is invalid|, %{schema: schema} do
      refute valid?(schema, %{
               "foo\tbar" => "1",
               "foo\nbar" => "1",
               "foo\fbar" => "1",
               "foo\rbar" => "1",
               "foo\"bar" => "1",
               "foo\\bar" => "1"
             })
    end
  end
end
