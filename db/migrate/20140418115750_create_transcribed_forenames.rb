class CreateTranscribedForenames < ActiveRecord::Migration
  def change
    create_table :transcribed_forenames do |t|
      t.string :name
      t.integer :frequency
      t.string :role
      t.boolean :simple
      t.boolean :ucf
      t.boolean :multiple

      t.timestamps
    end
  end
end
