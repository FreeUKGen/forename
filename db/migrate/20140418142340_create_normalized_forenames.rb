class CreateNormalizedForenames < ActiveRecord::Migration
  def change
    create_table :normalized_forenames do |t|
      t.string :name
      t.integer :frequency
      t.integer :number_of_sources
      t.boolean :ucf

      t.timestamps
    end
  end
end
