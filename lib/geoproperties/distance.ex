defmodule GeoProperties.Distance do
  @moduledoc """
  Calculates distance between two Geo.Point structs.
  """

  @spec distance({number(), number()}, {number(), number()}) :: float()
  def distance({x1, y1}, {x2, y2}) do
    :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))
  end
end
