defmodule Butike.Helpers.EnumHelperTest do
    use ExUnit.Case 
    alias Butike.Helpers.EnumHelper

    test "sanatize list should convert string numbers into their string type" do
        assert EnumHelper.sanatize(["254757161010","sale","1.72","37","testing_item_name","item description","3","m-pesa"]) == [254757161010,"sale",1.72,37,"testing_item_name","item description",3,"m-pesa"] 
    end
end