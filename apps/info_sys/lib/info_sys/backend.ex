defmodule InfoSys.Backend do
  # Behaviour
  @callback name() :: String.t()
  @callback compute(query :: String.t(), opts :: Keyword.t()) :: [%InfoSys.Result{}]
end
