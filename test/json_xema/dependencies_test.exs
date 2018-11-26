defmodule JsonXema.Dependencies do
  use ExUnit.Case, async: true

  test "dependencies with boolean subschemas and string keys" do
    schema = JsonXema.new(~s(
        {
          "dependencies": {
            "foo": true,
            "bar": false
          }
        }
      ))

    assert schema.schema.dependencies["bar"] == %Xema.Schema{type: false}
    assert schema.schema.dependencies["foo"] == %Xema.Schema{type: true}
  end
end
