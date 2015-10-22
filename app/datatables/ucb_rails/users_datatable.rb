class UcbRails::UsersDatatable < UcbRails::BaseDatatable

  private

  def default_scope
    UcbRails::User
  end
  
  def column_names
    @column_names ||= %w[admin inactive first_name last_name email alternate_email phone last_request_at uid]
  end
  
  def search(search_term)
    ["lower(first_name) like lower(:search) or lower(last_name) like lower(:search)", search: "#{search_term}%"]
  end
  
  def record_to_data(user)
    [
      user.admin? ? 1 : 0,
      user.inactive? ? 1 : 0,
      sanitize(user.first_name),
      sanitize(user.last_name),
      sanitize(user.email),
      sanitize(user.alternate_email),
      sanitize(user.phone),
      user.last_request_at.to_s,
      sanitize(user.uid),
      link_to("Edit", edit_ucb_rails_admin_user_path(user), :id => dom_id(user)),
      link_to('Delete', ucb_rails_admin_user_path(user), :method => :delete, :confirm => 'Are you sure?'),
    ]
  end

end
