class ChangeAllUserIdFieldsToString < ActiveRecord::Migration
  def change
    change_column :users, :affiliate_id, :string
    change_column :users, :student_id, :string
  end
end
