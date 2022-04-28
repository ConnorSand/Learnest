class RemoveLastNameFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :last_name, :string
    remove_column :questions, :first_name, :string
    remove_column :questions, :display_name, :string
    remove_column :questions, :about_me, :text
  end
end
