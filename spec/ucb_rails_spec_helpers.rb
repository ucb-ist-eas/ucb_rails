module UcbRailsSpecHelpers

  def login_user(user)
    session[:uid] = user.ldap_uid
  end

end
