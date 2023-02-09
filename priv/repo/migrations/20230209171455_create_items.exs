defmodule Butike.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :shop_msisdn, :string
      add :shop_item_id, :integer
      add :name, :text
      add :description, :text
      add :category, :text
      add :reorder_level, :integer
      add :quantity, :integer
      add :cost_price, :integer
      add :sale_price, :integer
      add :is_service, :integer
      add :note, :text
      add :meta_data, :text

      timestamps()
    end
  end
end
