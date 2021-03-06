class AddContentToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :content, :text
    add_column :questions, :is_archived, :boolean
    add_column :questions, :tags, :text
  end
end
