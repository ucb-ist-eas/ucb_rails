class AdminUsersController < ApplicationController
  def toggle_admin
    admin? ? current_user.update_column(:admin, false) : current_user.update_column(:admin, true)
    redirect_to root_path
  end
end