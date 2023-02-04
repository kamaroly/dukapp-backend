defmodule Butike.Factory do
	use ExMachina.Ecto, repo: Butike.Repo

	@doc """
	 Seed factorer
	"""
	def order_factory do
		%Butike.Backup.Order{
			phone_number: "254757161010", 
			order_type: "sale", 
			quantity: 50.3
		}
	end
end