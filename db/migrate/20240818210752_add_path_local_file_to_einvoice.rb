class AddPathLocalFileToEinvoice < ActiveRecord::Migration[7.1]
  def change
    add_column :einvoices, :file_name, :string
  end
end
