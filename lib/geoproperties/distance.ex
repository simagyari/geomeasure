defmodule GeoProperties.Distance do
  @moduledoc """
  Calculates distance between two coordinate pairs.
  """

  @doc """
  Calculates the distance between two coordinate pairs.

  ## Examples:

    iex> GeoProperties.Distance.distance({0, 0}, {5, 0})
    5.0

    iex> GeoProperties.Distance.distance({0, 0}, {3, 4})
    5.0

  """
  @doc since: "0.0.1"
  @spec distance({number(), number()}, {number(), number()}) :: float()
  def distance({x1, y1}, {x2, y2}) do
    :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))
  end
end
