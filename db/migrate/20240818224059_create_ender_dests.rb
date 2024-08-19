class CreateEnderDests < ActiveRecord::Migration[7.1]
  def change
    create_table :ender_dests do |t|
      t.references :dest, null: false, foreign_key: true
      t.string :x_lgr
      t.string :nro
      t.string :x_bairro
      t.string :c_mun
      t.string :x_mun
      t.string :uf
      t.string :cep
      t.string :c_pais
      t.string :x_pais

      t.timestamps
    end
  end
end
