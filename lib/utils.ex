defmodule GeoMeasure.Utils do
  @moduledoc """
  Contains utility functions to aid the correct handling of data in GeoMeasure.
  """

  @doc """
  Checks if neither of the tuple elements is nil.
  """
  @doc since: "0.0.1"
  @spec tuple_not_nil!({number() | nil, number() | nil}) :: ArgumentError
  def tuple_not_nil!({x, y}) do
    if is_nil(x) or is_nil(y) do
      raise ArgumentError, message: "Tuple contains nil value: {#{inspect(x)}, #{inspect(y)}}"
    end
  end
end
