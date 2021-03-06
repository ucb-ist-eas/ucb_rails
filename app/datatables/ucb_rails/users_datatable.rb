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
      bln(user.admin),
      bln(user.inactive),
      h(user.first_name),
      h(user.last_name),
      h(user.email),
      h(user.alternate_email),
      h(user.phone),
      h(user.last_request_at),
      h(user.uid),
      link_to("Edit", edit_ucb_rails_admin_user_path(user), :id => dom_id(user)),
      link_to('Delete', ucb_rails_admin_user_path(user), :method => :delete, :confirm => 'Are you sure?'),
    ]
  end

end
