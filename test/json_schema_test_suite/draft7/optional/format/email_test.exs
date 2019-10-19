defmodule JsonSchemaTestSuite.Draft7.Optional.Format.EmailTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe "validation of e-mail addresses" do
    setup do
      %{schema: JsonXema.new(%{"format" => "email"})}
    end

    test "a valid e-mail address", %{schema: schema} do
      assert valid?(schema, "joe.bloggs@example.com")
    end

    test "an invalid e-mail address", %{schema: schema} do
      refute valid?(schema, "2962")
    end
  end
end
