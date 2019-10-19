defmodule JsonSchemaTestSuite.Draft4.PropertiesTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe "object properties validation" do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "properties" => %{"bar" => %{"type" => "string"}, "foo" => %{"type" => "integer"}}
          })
      }
    end

    test "both properties present and valid is valid", %{schema: schema} do
      assert valid?(schema, %{"bar" => "baz", "foo" => 1})
    end

    test "one property invalid is invalid", %{schema: schema} do
      refute valid?(schema, %{"bar" => %{}, "foo" => 1})
    end

    test "both properties invalid is invalid", %{schema: schema} do
      refute valid?(schema, %{"bar" => %{}, "foo" => []})
    end

    test "doesn't invalidate other properties", %{schema: schema} do
      assert valid?(schema, %{"quux" => []})
    end

    test "ignores arrays", %{schema: schema} do
      assert valid?(schema, [])
    end

    test "ignores other non-objects", %{schema: schema} do
      assert valid?(schema, 12)
    end
  end

  describe "properties, patternProperties, additionalProperties interaction" do
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

    test "property validates property", %{schema: schema} do
      assert valid?(schema, %{"foo" => [1, 2]})
    end

    test "property invalidates property", %{schema: schema} do
      refute valid?(schema, %{"foo" => [1, 2, 3, 4]})
    end

    test "patternProperty invalidates property", %{schema: schema} do
      refute valid?(schema, %{"foo" => []})
    end

    test "patternProperty validates nonproperty", %{schema: schema} do
      assert valid?(schema, %{"fxo" => [1, 2]})
    end

    test "patternProperty invalidates nonproperty", %{schema: schema} do
      refute valid?(schema, %{"fxo" => []})
    end

    test "additionalProperty ignores property", %{schema: schema} do
      assert valid?(schema, %{"bar" => []})
    end

    test "additionalProperty validates others", %{schema: schema} do
      assert valid?(schema, %{"quux" => 3})
    end

    test "additionalProperty invalidates others", %{schema: schema} do
      refute valid?(schema, %{"quux" => "foo"})
    end
  end

  describe "properties with escaped characters" do
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

    test "object with all numbers is valid", %{schema: schema} do
      assert valid?(schema, %{
               "foo\tbar" => 1,
               "foo\nbar" => 1,
               "foo\fbar" => 1,
               "foo\rbar" => 1,
               "foo\"bar" => 1,
               "foo\\bar" => 1
             })
    end

    test "object with strings is invalid", %{schema: schema} do
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