defmodule Xema.NilTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  alias JsonXema.ValidationError

  describe "'nil' schema" do
    setup do
      %{schema: ~s({"type": "null"}) |> Jason.decode!() |> JsonXema.new()}
    end

    test "validate/2 with nil value", %{schema: schema} do
      assert validate(schema, nil) == :ok
    end

    test "validate/2 with non-nil value", %{schema: schema} do
      assert {:error, error} = validate(schema, 1)
      assert error == %ValidationError{reason: %{type: "null", value: 1}}
    end
  end
end
