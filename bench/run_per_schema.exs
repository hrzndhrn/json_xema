defmodule Bench do
  def json_xema(path) do
    schema =
      "bench/schema"
      |> Path.join(path)
      |> File.read!()
      |> Jason.decode!()
      |> JsonXema.new()

    fn data ->
      true = JsonXema.valid?(schema, data)
    end
  end

  def ex_json_schema(path) do
    schema =
      "bench/schema"
      |> Path.join(path)
      |> File.read!()
      |> Jason.decode!()
      |> ExJsonSchema.Schema.resolve()

    fn data ->
      true = ExJsonSchema.Validator.valid?(schema, data)
    end
  end

  def data(path),
    do:
      "bench/data"
      |> Path.join(path)
      |> File.read!()
      |> Jason.decode!()

  def run,
    do:
      "bench/schema"
      |> File.ls!()
      |> Enum.each(&bench/1)

  defp bench(name) do
    IO.puts("\nSchema: #{name}\n")

    schema = %{
      "JsonXema" => json_xema(name),
      "ExJsonSchema" => ex_json_schema(name)
    }

    json = %{
      json: data(name)
    }

    Benchee.run(schema,
      parallel: 4,
      inputs: json,
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
