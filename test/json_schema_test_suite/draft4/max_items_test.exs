defmodule JsonSchemaTestSuite.Draft4.MaxItemsTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|maxItems validation| do
    setup do
      %{schema: JsonXema.new(%{"maxItems" => 2})}
    end

    test ~s|shorter is valid|, %{schema: schema} do
      assert valid?(schema, [1])
    end

    test ~s|exact length is valid|, %{schema: schema} do
      assert valid?(schema, [1, 2])
    end

    test ~s|too long is invalid|, %{schema: schema} do
      refute valid?(schema, [1, 2, 3])
    end

    test ~s|ignores non-arrays|, %{schema: schema} do
      assert valid?(schema, "foobar")
    end
  end
end
