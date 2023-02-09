defmodule Butike.Helpers.StringHelper do
  @moduledoc """
  Module to help convert string to number
  """

  @doc """
  Convert a string with number to integer
  """
  def to_integer(int_string) do
    try do
      cond do
        is_integer(int_string) -> int_string
        true -> String.to_integer(int_string)
      end
    rescue
      _exception ->
        int_string
    end
  end

  @doc """
   Converts a string to float with decimals
  """
  def to_float(float_string) do
    try do
      cond do
        is_float(float_string) -> float_string
        true -> String.to_float(float_string)
      end
    rescue
      _exception ->
        float_string
    end
  end

  @doc """
  Convert string to number
  """
  def to_number(number_string) do
    int_number = to_integer(number_string)
    float_number = to_float(number_string)

    cond do
      is_integer(int_number) -> int_number
      is_float(float_number) -> float_number
      true -> number_string
    end
  end

  @doc """
  Hases a given string
  """
  def hash_md5(string) do
    :crypto.hash(:md5, string) |> Base.encode16()
  end
end
