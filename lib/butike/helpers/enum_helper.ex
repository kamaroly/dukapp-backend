defmodule Butike.Helpers.EnumHelper do
    
    alias Butike.Helpers.StringHelper

    def sanatize(list) do
        Enum.map(list, fn(item) -> StringHelper.to_number(item) end) 
    end

end