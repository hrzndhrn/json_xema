defmodule JsonXema.ChromeExtensionTest do
  use ExUnit.Case, async: true

  import JsonXema, only: [validate: 2]

  describe "chrome extension schema" do
    setup do
      %{schema: JsonXema.new(schema())}
    end

    test "with valid data", %{schema: schema} do
      assert validate(schema, data()) == :ok
    end
  end

  describe "chrome extension schema (non-inline)" do
    setup do
      %{schema: JsonXema.new(schema(), inline: false)}
    end

    @tag :only
    test "with valid data", %{schema: schema} do
      assert validate(schema, data()) == :ok
    end
  end


  defp schema,
    do:
      "test/support/schema/chrome_extension.json"
      |> File.read!()
      |> Jason.decode!()

  defp data,
    do:
      """
      {
        "name": "Great App Name",
        "description": "Pithy description (132 characters or less, no HTML)",
        "version": "0.0.0.1",
        "manifest_version": 2,
        "icons": {
          "128": "icon_128.png"
        },
        "app": {
          "urls": [
            "http://mysubdomain.example.com/"
          ],
          "launch": {
            "web_url": "http://mysubdomain.example.com/"
          }
        }
      }
      """
      |> Jason.decode!()
end
