class CreateXmlFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :xml_files do |t|
      t.string :id_nfe
      t.string :version

      t.timestamps
    end
  end
end
