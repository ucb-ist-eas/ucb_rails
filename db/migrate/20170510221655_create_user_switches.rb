class CreateUserSwitches < ActiveRecord::Migration
  def change
    create_table :user_switches do |t|
      t.string :uid, null: false
      t.string :switch_uid
      t.timestamps
    end
  end
end
