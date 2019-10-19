defmodule JsonSchemaTestSuite.Draft6.RequiredTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe "required validation" do
    setup do
      %{
        schema:
          JsonXema.new(%{"properties" => %{"bar" => %{}, "foo" => %{}}, "required" => ["foo"]})
      }
    end

    test "present required property is valid", %{schema: schema} do
      assert valid?(schema, %{"foo" => 1})
    end

    test "non-present required property is invalid", %{schema: schema} do
      refute valid?(schema, %{"bar" => 1})
    end

    test "ignores arrays", %{schema: schema} do
      assert valid?(schema, [])
    end

    test "ignores strings", %{schema: schema} do
      assert valid?(schema, "")
    end

    test "ignores other non-objects", %{schema: schema} do
      assert valid?(schema, 12)
    end
  end

  describe "required default validation" do
    setup do
      %{schema: JsonXema.new(%{"properties" => %{"foo" => %{}}})}
    end

    test "not required by default", %{schema: schema} do
      assert valid?(schema, %{})
    end
  end

  describe "required with empty array" do
    setup do
      %{schema: JsonXema.new(%{"properties" => %{"foo" => %{}}, "required" => []})}
    end

    test "property not required", %{schema: schema} do
      assert valid?(schema, %{})
    end
  end

  describe "required with escaped characters" do
    setup do
      %{
        schema:
          JsonXema.new(%{
            "required" => ["foo\nbar", "foo\"bar", "foo\\bar", "foo\rbar", "foo\tbar", "foo\fbar"]
          })
      }
    end

    test "object with all properties present is valid", %{schema: schema} do
      assert valid?(schema, %{
               "foo\tbar" => 1,
               "foo\nbar" => 1,
               "foo\fbar" => 1,
               "foo\rbar" => 1,
               "foo\"bar" => 1,
               "foo\\bar" => 1
             })
    end

    test "object with some properties missing is invalid", %{schema: schema} do
      refute valid?(schema, %{"foo\nbar" => "1", "foo\"bar" => "1"})
    end
  end
end
