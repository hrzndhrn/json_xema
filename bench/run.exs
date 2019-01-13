defmodule Bench do
  def json_xema(raw) do
    schema = JsonXema.new(raw)

    fn data ->
      true = JsonXema.valid?(schema, data)
    end
  end

  def ex_json_schema(raw) do
    schema = ExJsonSchema.Schema.resolve(raw)

    fn data ->
      true = ExJsonSchema.Validator.valid?(schema, data)
    end
  end

  def schema do
    properties =
      "bench/schema"
      |> File.ls!()
      |> Enum.into(%{}, fn name ->
        {name,
         "bench/schema"
         |> Path.join(name)
         |> File.read!()
         |> Jason.decode!()}
      end)

    %{"properties" => properties}
  end

  def data,
    do:
      "bench/data"
      |> File.ls!()
      |> Enum.into(%{}, fn name ->
        {name,
         "bench/data"
         |> Path.join(name)
         |> File.read!()
         |> Jason.decode!()}
      end)

  def run do
    schema = schema()

    functions = %{
      "JsonXema" => json_xema(schema),
      "ExJsonSchema" => ex_json_schema(schema)
    }

    json = %{
      json: data()
    }

    Benchee.run(functions,
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
