defmodule Bench do
  def json_xema(path),
    do:
      "bench/schema"
      |> Path.join(path)
      |> File.read!()
      |> Jason.decode!()
      |> JsonXema.new()

  def ex_json_schema(path),
    do:
      "bench/schema"
      |> Path.join(path)
      |> File.read!()
      |> Jason.decode!()
      |> ExJsonSchema.Schema.resolve()

  def json(path),
    do:
      "bench/data"
      |> Path.join(path)
      |> File.read!()
      |> Jason.decode!()

  def json_xema_valid?(%{json_xema: schema, json: json}),
    do: true = JsonXema.valid?(schema, json)

  def ex_json_schema_valid?(%{ex_json_schema: schema, json: json}),
    do: true = ExJsonSchema.Validator.valid?(schema, json)

  def run do
    inputs =
      "bench/schema"
      |> File.ls!()
      |> Enum.into(%{}, fn name ->
        {name,
         %{
           json_xema: json_xema(name),
           ex_json_schema: ex_json_schema(name),
           json: json(name)
         }}
      end)

    Benchee.run(
      %{
        "JsonXema" => &json_xema_valid?/1,
        "ExJsonSchema" => &ex_json_schema_valid?/1
      },
      time: 10,
      inputs: inputs,
      print: [fast_warning: false],
      formatters: [
        # {Benchee.Formatters.HTML,
        #  file: Path.expand("output/bench.html", __DIR__)},
        Benchee.Formatters.Console
      ],
      formatter_options: [
        html: []
      ]
    )
  end
end

Bench.run()
