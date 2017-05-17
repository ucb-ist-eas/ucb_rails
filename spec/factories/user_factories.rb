FactoryGirl.define do

  factory :user do
    ldap_uid { (100 + rand(100000)).to_s }
    employee_id { (100 + rand(100000)).to_s }
    superuser_flag false
    inactive_flag false
    first_name "Ucb"
    last_name "User"
    email "ucbuser@dummy.edu"
  end

  factory :superuser, parent: :user do
    superuser_flag true
  end

end
