class CreateUniversities < ActiveRecord::Migration[6.1]
  def change
    create_table :universities do |t|
      t.string :name
      t.string :country
      t.string :location

      t.timestamps
    end
  end
end
