defmodule JsonXema.JsonTest do
  use ExUnit.Case, async: true

  alias JsonXema.Json
  alias Jason.DecodeError

  test "decode!/1 returns term for valid input" do
    IO.puts :code.priv_dir(:json_xema)
    assert Json.decode!(
             ~s({"age":44,"name":"Steve Irwin","nationality":"Australian"})
           ) ==
             %{
               "age" => 44,
               "name" => "Steve Irwin",
               "nationality" => "Australian"
             }
  end

  test "decode!/1 returns error tuple for invalid input" do
    assert_raise DecodeError, fn -> Json.decode!(~s({"age":})) == :error end
  end
end
