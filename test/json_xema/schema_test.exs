defmodule Xema.SchemaTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  describe "schema draft04" do
    setup do
      IO.inspect File.cwd()
      draft04 = File.read!("test/support/schema/draft04.json")
      %{draft04: JsonXema.new(draft04)}
    end

    test "bla" do
      assert 1 == 1
    end
  end
end
