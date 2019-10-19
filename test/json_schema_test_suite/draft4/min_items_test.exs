defmodule JsonSchemaTestSuite.Draft4.MinItemsTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe "minItems validation" do
    setup do
      %{schema: JsonXema.new(%{"minItems" => 1})}
    end

    test "longer is valid", %{schema: schema} do
      assert valid?(schema, [1, 2])
    end

    test "exact length is valid", %{schema: schema} do
      assert valid?(schema, [1])
    end

    test "too short is invalid", %{schema: schema} do
      refute valid?(schema, [])
    end

    test "ignores non-arrays", %{schema: schema} do
      assert valid?(schema, "")
    end
  end
end
