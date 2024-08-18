class CreateDests < ActiveRecord::Migration[7.1]
  def change
    create_table :dests do |t|
      t.references :einvoice, null: false, foreign_key: true
      t.string :cnpj
      t.string :x_nome
      t.string :ind_ie_dest

      t.timestamps
    end
  end
end
