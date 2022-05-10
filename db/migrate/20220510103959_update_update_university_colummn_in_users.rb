class UpdateUpdateUniversityColummnInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :university_id, true
  end
end
