defmodule JsonSchemaTestSuite.Draft7.Optional.Format.Ipv6Test do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe "validation of IPv6 addresses" do
    setup do
      %{schema: JsonXema.new(%{"format" => "ipv6"})}
    end

    test "a valid IPv6 address", %{schema: schema} do
      assert valid?(schema, "::1")
    end

    test "an IPv6 address with out-of-range values", %{schema: schema} do
      refute valid?(schema, "12345::")
    end

    test "an IPv6 address with too many components", %{schema: schema} do
      refute valid?(schema, "1:1:1:1:1:1:1:1:1:1:1:1:1:1:1:1")
    end

    test "an IPv6 address containing illegal characters", %{schema: schema} do
      refute valid?(schema, "::laptop")
    end
  end
end
