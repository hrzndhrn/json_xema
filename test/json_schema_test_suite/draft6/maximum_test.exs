defmodule JsonSchemaTestSuite.Draft6.MaximumTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|maximum validation| do
    setup do
      %{schema: JsonXema.new(%{"maximum" => 3.0})}
    end

    test ~s|below the maximum is valid|, %{schema: schema} do
      assert valid?(schema, 2.6)
    end

    test ~s|boundary point is valid|, %{schema: schema} do
      assert valid?(schema, 3.0)
    end

    test ~s|above the maximum is invalid|, %{schema: schema} do
      refute valid?(schema, 3.5)
    end

    test ~s|ignores non-numbers|, %{schema: schema} do
      assert valid?(schema, "x")
    end
  end

  describe ~s|maximum validation with unsigned integer| do
    setup do
      %{schema: JsonXema.new(%{"maximum" => 300})}
    end

    test ~s|below the maximum is invalid|, %{schema: schema} do
      assert valid?(schema, 299.97)
    end

    test ~s|boundary point integer is valid|, %{schema: schema} do
      assert valid?(schema, 300)
    end

    test ~s|boundary point float is valid|, %{schema: schema} do
      assert valid?(schema, 300.0)
    end

    test ~s|above the maximum is invalid|, %{schema: schema} do
      refute valid?(schema, 300.5)
    end
  end
end
