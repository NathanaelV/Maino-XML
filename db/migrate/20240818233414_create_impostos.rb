class CreateImpostos < ActiveRecord::Migration[7.1]
  def change
    create_table :impostos do |t|
      t.references :item, null: false, foreign_key: true
      t.string :v_icms
      t.string :v_ipi

      t.timestamps
    end
  end
end
