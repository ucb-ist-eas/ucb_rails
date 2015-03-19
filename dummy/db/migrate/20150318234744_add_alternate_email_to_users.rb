class AddAlternateEmailToUsers < ActiveRecord::Migration
  def up
    unless column_exists?(:users, :alternate_email)
      add_column :users, :alternate_email, :string, :limit => 255 
    end
  end

  def down
    remove_column :users, :alternate_email
  end
end
