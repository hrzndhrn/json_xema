defmodule JsonSchemaTestSuite.Draft7.DefinitionsTest do
  use ExUnit.Case

  import JsonXema, only: [valid?: 2]

  describe ~s|valid definition| do
    setup do
      %{schema: JsonXema.new(%{"$ref" => "http://json-schema.org/draft-07/schema#"})}
    end

    test ~s|valid definition schema|, %{schema: schema} do
      assert valid?(schema, %{"definitions" => %{"foo" => %{"type" => "integer"}}})
    end
  end

  describe ~s|invalid definition| do
    setup do
      %{schema: JsonXema.new(%{"$ref" => "http://json-schema.org/draft-07/schema#"})}
    end

    test ~s|invalid definition schema|, %{schema: schema} do
      refute valid?(schema, %{"definitions" => %{"foo" => %{"type" => 1}}})
    end
  end
end
