defmodule StringHelperTest do
	use ExUnit.Case
	alias Butike.Helpers.StringHelper

	test "to_integer should return an integer if the string provided is an integer" do
		assert StringHelper.to_integer("783") == 783
	end

	test "to_integer should return the same string if it's not the number provided" do
		assert StringHelper.to_integer("Angel") == "Angel"
	end

	test "to_floast should return the float number with .0 suffix if the provided number is an integer" do
		assert StringHelper.to_float("3242.0") == 3242.0
	end

	test "to_float returns the same value if the provided string is not a float number" do
		assert StringHelper.to_float("Abantu3") == "Abantu3"
	end

	test "StringHelper can convert any string number to integer or float" do
		assert StringHelper.to_number("434317") == 434317
		assert StringHelper.to_number("434317.1") == 434317.1
		assert StringHelper.to_number("0.74") == 0.74

	end

	test "It should return the same string if provided string is not a number" do
		assert StringHelper.to_number("Kamaro") == "Kamaro"
	end
end