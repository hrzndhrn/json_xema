import Config

config :logger, level: :info

# ExJsonschema-specific logging configuration
config :ex_jsonschema,
  # Use info level for development (captures important operations without verbose tracing)
  log_level: :info,
  # Log compilation performance metrics
  log_compilation_time: true,
  # Log validation performance metrics
  log_validation_time: true,
  # Include detailed error context in logs
  log_error_details: true
