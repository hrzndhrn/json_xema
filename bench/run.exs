defmodule Bench do
  def json_xema(path) do
    schema =
      "bench/schema"
      |> Path.join(path)
      |> File.read!()
      |> Jason.decode!()
      |> JsonXema.new()

    fn data -> JsonXema.valid?(schema, data) end
  end

  def ex_json_schema(path) do
    schema =
      "bench/schema"
      |> Path.join(path)
      |> File.read!()
      |> Jason.decode!()
      |> ExJsonSchema.Schema.resolve()

    fn data -> ExJsonSchema.Validator.valid?(schema, data) end
  end

  def data(path),
    do:
      "bench/data"
      |> Path.join(path)
      |> File.read!()
      |> Jason.decode!()

  def run do
    basic()
  end

  defp basic() do
    basic_schema = %{
      "JsonXema" => json_xema("basic.json"),
      "ExJsonSchema" => ex_json_schema("basic.json")
    }

    basic_data = %{
      valid: data("valid/basic.json"),
      invalid: data("invalid/basic.json")
    }

    Benchee.run(basic_schema,
      parallel: 4,
      inputs: basic_data,
      print: [fast_warning: false],
      formatters: [
        # &Benchee.Formatters.HTML.output/1,
        &Benchee.Formatters.Console.output/1
      ],
      formatter_options: [
        html: [
          file: Path.expand("output/basic.html", __DIR__)
        ]
      ]
    )
  end
end

Bench.run()
