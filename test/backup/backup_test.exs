defmodule Backup.BackupTest do
  use ButikeWeb.ConnCase

  alias Butike.Backup.Backup
  alias Butike.Order.Order

  # 1. Create user in the database
  test "User can retrieve orders by shop phone" do
    order = %Order{
      coupon_lines: "[]",
      created_via: "mobile-app",
      customer_supplier_id: 123,
      customer_supplier_note: "Customer Notes",
      discount_tax: 20.0,
      discount_total: 10.0,
      fee_lines: "[]",
      meta_data: "[]",
      note: "Customer notes",
      order_key: "OrderKeys" <> Integer.to_string(Enum.random(100_000..999_999)),
      order_type: "SALE",
      payments: "[]",
      prices_include_tax: 0,
      refunds: "[]",
      shop_msisdn: "254757161010",
      shop_order_id: 1,
      status: "COMPLETED",
      tax_lines: "[]",
      total: 435.0,
      total_tax: 4340.0,
      version: "1"
    }

    Backup.create_order(order)
    Backup.create_order(order)

    stored_orders = Backup.list_orders_by_phone(order.shop_msisdn)

    assert Enum.count(stored_orders) == 2
  end

  test "get_orders_by_phone returns 0 results when there is no matching phone" do
    order = %Order{
      coupon_lines: "[]",
      created_via: "mobile-app",
      customer_supplier_id: 123,
      customer_supplier_note: "Customer Notes",
      discount_tax: 20.0,
      discount_total: 10.0,
      fee_lines: "[]",
      meta_data: "[]",
      note: "Customer notes",
      order_key: "OrderKeys" <> Integer.to_string(Enum.random(100_000..999_999)),
      order_type: "SALE",
      payments: "[]",
      prices_include_tax: 0,
      refunds: "[]",
      shop_msisdn: "254757161010",
      shop_order_id: 1,
      status: "COMPLETED",
      tax_lines: "[]",
      total: 435.0,
      total_tax: 4340.0,
      version: "1"
    }

    Backup.create_order(order)
    empty_orders = Backup.list_orders_by_phone("2547575772")

    assert Enum.count(empty_orders) == 0
  end
end
