class AddIndexToNames < ActiveRecord::Migration
  def change
    add_index :normalized_forenames, :name
  end
end
