defmodule JsonSchemaTestSuite.Draft7.PatternTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe "pattern validation" do
    setup do
      %{schema: JsonXema.new(%{"pattern" => "^a*$"})}
    end

    test "a matching pattern is valid", %{schema: schema} do
      assert valid?(schema, "aaa")
    end

    test "a non-matching pattern is invalid", %{schema: schema} do
      refute valid?(schema, "abc")
    end

    test "ignores non-strings", %{schema: schema} do
      assert valid?(schema, true)
    end
  end

  describe "pattern is not anchored" do
    setup do
      %{schema: JsonXema.new(%{"pattern" => "a+"})}
    end

    test "matches a substring", %{schema: schema} do
      assert valid?(schema, "xxaayy")
    end
  end
end