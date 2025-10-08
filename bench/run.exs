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

  def ex_jsonschema(path),
    do:
      "bench/schema"
      |> Path.join(path)
      |> File.read!()
      |> ExJsonschema.compile()
      |> elem(1)

  def json(path),
    do:
      "bench/data"
      |> Path.join(path)
      |> File.read!()
      |> Jason.decode!()

  def raw_json(path),
    do:
      "bench/data"
      |> Path.join(path)
      |> File.read!()

  def json_xema_valid?(%{json_xema: schema, json: json}),
    do: true = JsonXema.valid?(schema, json)

  def ex_json_schema_valid?(%{ex_json_schema: schema, json: json}),
    do: true = ExJsonSchema.Validator.valid?(schema, json)

  def ex_jsonschema_valid?(%{ex_jsonschema: schema, raw_json: json}),
    do: :ok = ExJsonschema.validate(schema, json)

  @perf_opts ExJsonschema.Options.new(:performance)

  def ex_jsonschema_valid_performance?(%{ex_jsonschema: schema, raw_json: json}),
    do: :ok = ExJsonschema.validate(schema, json, @perf_opts)

  def run do
    inputs =
      "bench/schema"
      |> File.ls!()
      |> Enum.into(%{}, fn name ->
        {name,
         %{
           json_xema: json_xema(name),
           ex_json_schema: ex_json_schema(name),
           ex_jsonschema: ex_jsonschema(name),
           json: json(name),
           raw_json: raw_json(name)
         }}
      end)

    Benchee.run(
      %{
        "JsonXema" => &json_xema_valid?/1,
        "ExJsonSchema" => &ex_json_schema_valid?/1,
        "ExJsonschema_RUST" => &ex_jsonschema_valid?/1,
        "ExJsonschema_RUST-Performance Profile" => &ex_jsonschema_valid_performance?/1
      },
      time: 1,
      inputs: inputs,
      print: [fast_warning: false],
      formatters: [
        {Benchee.Formatters.Markdown, file: Path.expand("README.md", __DIR__)},
        Benchee.Formatters.Console
      ]
    )
  end
end

Bench.run()
