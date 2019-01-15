defmodule JsonXema.FormatTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [valid?: 2]

  describe "ignore unknown format" do
    setup do
      %{
        schema: ~s({"format" : "whatever"}) |> Jason.decode!() |> JsonXema.new()
      }
    end

    test "validate/2 with a string", %{schema: schema} do
      assert valid?(schema, "what ever floats your boat")
    end
  end
end
