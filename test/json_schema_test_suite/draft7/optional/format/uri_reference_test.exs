defmodule JsonSchemaTestSuite.Draft7.Optional.Format.UriReferenceTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe "validation of URI References" do
    setup do
      %{schema: JsonXema.new(%{"format" => "uri-reference"})}
    end

    test "a valid URI", %{schema: schema} do
      assert valid?(schema, "http://foo.bar/?baz=qux#quux")
    end

    test "a valid protocol-relative URI Reference", %{schema: schema} do
      assert valid?(schema, "//foo.bar/?baz=qux#quux")
    end

    test "a valid relative URI Reference", %{schema: schema} do
      assert valid?(schema, "/abc")
    end

    test "an invalid URI Reference", %{schema: schema} do
      refute valid?(schema, "\\\\WINDOWS\\fileshare")
    end

    test "a valid URI Reference", %{schema: schema} do
      assert valid?(schema, "abc")
    end

    test "a valid URI fragment", %{schema: schema} do
      assert valid?(schema, "#fragment")
    end

    test "an invalid URI fragment", %{schema: schema} do
      refute valid?(schema, "#frag\\ment")
    end
  end
end
