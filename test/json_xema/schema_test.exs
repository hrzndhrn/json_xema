defmodule Xema.SchemaTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  describe "schema draft04" do
    setup do
      %{
        draft04:
        "test/support/schema/draft04.json"
        |> File.read!()
        |> JsonXema.new()
      }
    end

    test "empty object", %{draft04: schema} do
      assert validate(schema, "{}" |> Jason.decode!()) == :ok
    end
  end
end
