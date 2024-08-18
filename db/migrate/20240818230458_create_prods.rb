class CreateProds < ActiveRecord::Migration[7.1]
  def change
    create_table :prods do |t|
      t.references :item, null: false, foreign_key: true
      t.string :x_prod
      t.string :ncm
      t.string :cfop
      t.string :u_com
      t.string :q_com
      t.string :v_un_com

      t.timestamps
    end
  end
end
