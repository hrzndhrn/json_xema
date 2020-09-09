defmodule JsonSchemaTestSuite.Draft4.MinimumTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|minimum validation| do
    setup do
      %{schema: JsonXema.new(%{"minimum" => 1.1})}
    end

    test ~s|above the minimum is valid|, %{schema: schema} do
      assert valid?(schema, 2.6)
    end

    test ~s|boundary point is valid|, %{schema: schema} do
      assert valid?(schema, 1.1)
    end

    test ~s|below the minimum is invalid|, %{schema: schema} do
      refute valid?(schema, 0.6)
    end

    test ~s|ignores non-numbers|, %{schema: schema} do
      assert valid?(schema, "x")
    end
  end

  describe ~s|minimum validation (explicit false exclusivity)| do
    setup do
      %{schema: JsonXema.new(%{"exclusiveMinimum" => false, "minimum" => 1.1})}
    end

    test ~s|above the minimum is valid|, %{schema: schema} do
      assert valid?(schema, 2.6)
    end

    test ~s|boundary point is valid|, %{schema: schema} do
      assert valid?(schema, 1.1)
    end

    test ~s|below the minimum is invalid|, %{schema: schema} do
      refute valid?(schema, 0.6)
    end

    test ~s|ignores non-numbers|, %{schema: schema} do
      assert valid?(schema, "x")
    end
  end

  describe ~s|exclusiveMinimum validation| do
    setup do
      %{schema: JsonXema.new(%{"exclusiveMinimum" => true, "minimum" => 1.1})}
    end

    test ~s|above the minimum is still valid|, %{schema: schema} do
      assert valid?(schema, 1.2)
    end

    test ~s|boundary point is invalid|, %{schema: schema} do
      refute valid?(schema, 1.1)
    end
  end

  describe ~s|minimum validation with signed integer| do
    setup do
      %{schema: JsonXema.new(%{"minimum" => -2})}
    end

    test ~s|negative above the minimum is valid|, %{schema: schema} do
      assert valid?(schema, -1)
    end

    test ~s|positive above the minimum is valid|, %{schema: schema} do
      assert valid?(schema, 0)
    end

    test ~s|boundary point is valid|, %{schema: schema} do
      assert valid?(schema, -2)
    end

    test ~s|boundary point with float is valid|, %{schema: schema} do
      assert valid?(schema, -2.0)
    end

    test ~s|float below the minimum is invalid|, %{schema: schema} do
      refute valid?(schema, -2.0001)
    end

    test ~s|int below the minimum is invalid|, %{schema: schema} do
      refute valid?(schema, -3)
    end

    test ~s|ignores non-numbers|, %{schema: schema} do
      assert valid?(schema, "x")
    end
  end
end
