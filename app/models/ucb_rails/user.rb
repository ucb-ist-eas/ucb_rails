class UcbRails::User < ActiveRecord::Base
  self.table_name = 'users'

  # attr_accessible :uid, :first_name, :last_name, :inactive

  # Overridden by application
  def roles
    []
  end

  def has_role?(role)
    admin? || roles.include?(role)
  end

  def active?
    !inactive?
  end

  def admin!(_admin=true)
    update_attribute(:admin, _admin)
  end

  def inactive!(_inactive=true)
    update_attribute(:inactive, _inactive)
  end

  def self.active
    where(inactive: false)
  end

  def self.admin
    where(admin: true)
  end

  def ldap_entry
    UcbRails::LdapPerson::Finder.find_by_uid!(uid)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def uid
    ldap_uid
  end

end
