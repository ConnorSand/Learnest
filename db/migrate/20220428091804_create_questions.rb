class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :last_name
      t.string :first_name
      t.string :display_name
      t.text :about_me

      t.timestamps
    end
  end
end
