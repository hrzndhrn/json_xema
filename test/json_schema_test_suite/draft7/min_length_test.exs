defmodule JsonSchemaTestSuite.Draft7.MinLengthTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|minLength validation| do
    setup do
      %{schema: JsonXema.new(%{"minLength" => 2})}
    end

    test ~s|longer is valid|, %{schema: schema} do
      assert valid?(schema, "foo")
    end

    test ~s|exact length is valid|, %{schema: schema} do
      assert valid?(schema, "fo")
    end

    test ~s|too short is invalid|, %{schema: schema} do
      refute valid?(schema, "f")
    end

    test ~s|ignores non-strings|, %{schema: schema} do
      assert valid?(schema, 1)
    end

    test ~s|one supplementary Unicode code point is not long enough|, %{schema: schema} do
      refute valid?(schema, "💩")
    end
  end
end
