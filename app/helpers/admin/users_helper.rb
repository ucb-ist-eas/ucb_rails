module Admin
  module UsersHelper

    def link_to_new_user
      text = 'New User'
      # text = image_tag('ucb_rails/glyphicons_006_user_add.png', size: '14x14')
      button(text, :primary,
        class: 'ldap-person-search',
        data: {
          #search_url: ldap_search_ucb_rails_admin_users_path,
          search_url: "",
          result_link_url: admin_users_path,
          result_link_http_method: 'post',
        }
      )
    end

  end
end
