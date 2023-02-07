defmodule Backup.BackupTest do
  use ButikeWeb.ConnCase

  alias Butike.Backup.Order
  alias Butike.Backup

  test "User can retrieve orders by shop phone" do
    # 1. Create user in the database
    order = %Order{
      shop_msisdn: "250781854852",
      order_type: "purchase",
      item_id: 43,
      item_name: "Sale Item",
      item_description: "Why is this even a sale",
      customer_or_supplier_id: 1,
      quantity: 43,
      cost_price: 2,
      sale_price: 3,
      payment_mode: "m-pesa"
    }

    Backup.create_order(order)
    Backup.create_order(order)

    stored_orders = Backup.list_orders_by_phone(order.shop_msisdn)

    assert Enum.count(stored_orders) == 2
  end

  test "get_orders_by_phone returns 0 results when there is no matching phone" do
    order = %Order{
      shop_msisdn: "250781854852",
      order_type: "purchase",
      item_id: 43,
      item_name: "Sale Item",
      item_description: "Why is this even a sale",
      customer_or_supplier_id: 1,
      quantity: 43,
      cost_price: 2,
      sale_price: 3,
      payment_mode: "m-pesa"
    }

    Backup.create_order(order)
    empty_orders = Backup.list_orders_by_phone("2547575772")

    assert Enum.count(empty_orders) == 0
  end
end
