defmodule JsonXema.SchemaError do
  @moduledoc """
  Raised when a schema can't be build.
  """

  alias JsonXema.SchemaError

  defexception [:message, :reason]

  @impl true
  def exception(message) when is_binary(message),
    do: %SchemaError{message: message, reason: nil}

  def exception(reason),
    do: %SchemaError{
      message: "Can't build schema! Reason: #{Exception.message(reason)}",
      reason: reason
    }
end
