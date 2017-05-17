FactoryGirl.define do

  factory :user_switch do
    uid { create(:user).ldap_uid }
    switch_uid { create(:user).ldap_uid }
  end

end
