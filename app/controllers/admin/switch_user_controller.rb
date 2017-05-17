class Admin::SwitchUserController < Admin::BaseController
  skip_before_filter :ensure_admin_user, only: :switch_back

  UserInSession = Struct.new(:ldap_uid, :name, :superuser)

  def index
    uid = session[:logged_in_user].try(:ldap_uid) || session[:uid]
    @recent_switches = UserSwitch.recent_for(uid)
    @all_switches = UserSwitch.all_for(uid)
  end

  def switch_user
    if uid.present?
      other_user = User.find_by_ldap_uid!(uid)
      save_logged_in_user
      switch_to_other_user(other_user)
    else
      redirect_to({action: "index"}, flash: {error: "Select a user."})
    end
  end

  def switch_back
    if actual_user.present?
      UserSwitch.create!(uid: actual_user.ldap_uid, switch_uid: actual_user.ldap_uid)
      session[:uid] = actual_user.ldap_uid
      redirect_to({action: "index"}, flash: {success: "Switched back to #{actual_user.name}"})
    else
      redirect_to logout_path
    end
  end

  private

  def uid
    params[:uid]
  end

  def save_logged_in_user
    unless session[:logged_in_user].present?
      logged_in_user = UserInSession.new(current_user.ldap_uid,
                                         current_user.full_name,
                                         current_user.superuser?)
      session[:logged_in_user] = logged_in_user
    end
  end

  def switch_to_other_user(other_user)
    UserSwitch.create!(uid: actual_user.ldap_uid, switch_uid: other_user.ldap_uid)
    session[:user_switches] = UserSwitch.recent_for(actual_user.ldap_uid)
    session[:uid] = uid
    redirect_to({action: "index"}, flash: {success: "Switched to #{other_user.full_name}"})
  end

  def actual_user
    session[:logged_in_user]
  end
end
