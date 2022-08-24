class AddTotalAmountToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :total_amount, :string
  end
end
