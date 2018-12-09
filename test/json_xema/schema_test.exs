defmodule Xema.SchemaTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  describe "validat/2 whith schema draft04" do
    setup do
      %{
        draft04:
          "test/support/schema/draft04.json"
          |> File.read!()
          |> JsonXema.new()
      }
    end

    test "returns :ok for empty object", %{draft04: schema} do
      # IO.inspect(schema |> JsonXema.to_xema |> Xema.source)
      assert validate(schema, "{}" |> Jason.decode!()) == :ok
    end

    test "returns an error for a wrong type", %{draft04: schema} do
      data =
        Jason.decode!("""
          {"type": "foo"}
        """)

      assert validate(schema, data) ==
               {:error,
                %{
                  properties: %{
                    "type" => %{
                      anyOf: [
                        %{
                          enum: [
                            "array",
                            "boolean",
                            "integer",
                            "null",
                            "number",
                            "object",
                            "string"
                          ],
                          value: "foo"
                        },
                        %{type: "array", value: "foo"}
                      ],
                      value: "foo"
                    }
                  }
                }}
    end
  end
end
