defmodule GeoMeasure.Utils do
  @moduledoc """
  Contains utility functions to aid the correct handling of data in GeoMeasure.
  """

  @doc """
  Checks if neither of the tuple elements is nil.
  """
  @doc since: "0.0.1"
  @spec tuple_not_nil!(Tuple) :: ArgumentError
  def tuple_not_nil!(tpl) when is_tuple(tpl) do
    tpl
    |> Tuple.to_list()
    |> Enum.map(fn x ->
      if is_nil(x) do
        raise ArgumentError, message: "Tuple contains nil value: {#{inspect(tpl)}}"
      end
    end)
  end
end
