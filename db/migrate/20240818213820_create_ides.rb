class CreateIdes < ActiveRecord::Migration[7.1]
  def change
    create_table :ides do |t|
      t.references :einvoice, null: false, foreign_key: true
      t.string :serie
      t.string :n_nf
      t.string :dh_emi

      t.timestamps
    end
  end
end
