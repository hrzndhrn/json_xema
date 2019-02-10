defmodule JsonXema.JsonTest do
  use ExUnit.Case, async: true

  alias JsonXema.Json

  test "decode/1 returns ok tuple for valid input" do
    assert Json.decode(
             ~s({"age":44,"name":"Steve Irwin","nationality":"Australian"})
           ) ==
             {:ok,
              %{
                "age" => 44,
                "name" => "Steve Irwin",
                "nationality" => "Australian"
              }}
  end

  test "decode/1 returns error tuple for invalid input" do
    assert Json.decode(
             ~s({"age":})
           ) ==
             {:error,
              %Jason.DecodeError{
                data:
                  "{\"age\":}",
                position: 7,
                token: nil
              }}
  end
end
