defmodule Draft7.Optional.Format.Ipv6Test do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "validation of IPv6 addresses" do
    setup do
      %{schema: ~s(
        {
          "format": "ipv6"
        }
        ) |> Jason.decode!() |> JsonXema.new()}
    end

    test "a valid IPv6 address", %{schema: schema} do
      data = "::1"
      assert valid?(schema, data)
    end

    test "an IPv6 address with out-of-range values", %{schema: schema} do
      data = "12345::"
      refute valid?(schema, data)
    end

    test "an IPv6 address with too many components", %{schema: schema} do
      data = "1:1:1:1:1:1:1:1:1:1:1:1:1:1:1:1"
      refute valid?(schema, data)
    end

    test "an IPv6 address containing illegal characters", %{schema: schema} do
      data = "::laptop"
      refute valid?(schema, data)
    end
  end
end
