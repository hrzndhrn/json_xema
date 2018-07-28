defmodule JsonXema.Dependencies do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

    test "dependencies with boolean subschemas and string keys" do
      schema = JsonXema.new(~s(
        {
          "dependencies": {
            "foo": true,
            "bar": false
          }
        }
      ))

      assert schema.content.dependencies["bar"] == %Xema.Schema{type: false}
      assert schema.content.dependencies["foo"] == %Xema.Schema{type: true}
    end
end
