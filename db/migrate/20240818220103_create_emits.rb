class CreateEmits < ActiveRecord::Migration[7.1]
  def change
    create_table :emits do |t|
      t.references :einvoice, null: false, foreign_key: true
      t.string :cnpj
      t.string :x_nome
      t.string :x_fant
      t.string :ie
      t.string :crt

      t.timestamps
    end
  end
end
