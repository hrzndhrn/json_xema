defmodule JsonSchemaTestSuite.Draft6.ExclusiveMinimumTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe "exclusiveMinimum validation" do
    setup do
      %{schema: JsonXema.new(%{"exclusiveMinimum" => 1.1})}
    end

    test "above the exclusiveMinimum is valid", %{schema: schema} do
      assert valid?(schema, 1.2)
    end

    test "boundary point is invalid", %{schema: schema} do
      refute valid?(schema, 1.1)
    end

    test "below the exclusiveMinimum is invalid", %{schema: schema} do
      refute valid?(schema, 0.6)
    end

    test "ignores non-numbers", %{schema: schema} do
      assert valid?(schema, "x")
    end
  end
end
