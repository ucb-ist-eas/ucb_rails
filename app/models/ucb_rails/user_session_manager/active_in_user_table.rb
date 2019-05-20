module UcbRails
  module UserSessionManager
    class ActiveInUserTable < Base

      def login(uid)
        self.uid = uid

        if user_table_entry && people_ou_entry
          UcbRails::UserLdapService.update_user_from_ldap_entry(people_ou_entry).tap do |user|
            if UcbRails[:hcm_client]
              begin
                (first_name, last_name) = load_preferred_name_from_hcm(user)
                user.first_name = first_name if first_name.present?
                user.last_name = last_name if last_name.present?
              rescue Exception => e

              end
            end
            user.last_login_at = Time.now.utc
            user.save
          end
        else
          false
        end
      end

      def current_user(uid)
        UcbRails::User.find_by_uid(uid)
      end

      def log_request(user)
        user.present? and user.touch(:last_request_at)
      end

      def logout(user)
        user.present? and user.touch(:last_logout_at)
      end

      private

      def user_table_entry
        active_user
      end

      def load_preferred_name_from_hcm(user)
        return [nil, nil] if user.employee_id.blank?
        client = UcbRails[:hcm_client]
        response = client.get("/employees/" + user.employee_id, {"id-type" => "hr-employee-id"})
        names = response.all_fetchers.first.names.value
        preferred_name = names.find { |n| n["type"]["code"] == "PRF" }
        [preferred_name["givenName"], preferred_name["familyName"]]
      end

    end
  end
end
