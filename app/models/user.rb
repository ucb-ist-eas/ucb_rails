class User < ActiveRecord::Base
  # attr_accessible :uid, :first_name, :last_name, :inactive

  # Overridden by application
  def roles
    []
  end

  def has_role?(role)
    superuser? || roles.include?(role)
  end

  def active?
    !inactive?
  end

  def inactive?
    inactive_flag
  end

  def superuser!(_superuser=true)
    update_attribute(:superuser_flag, _superuser)
  end

  def superuser?
    superuser_flag
  end

  def inactive!(_inactive=true)
    update_attribute(:inactive_flag, _inactive)
  end

  def self.active
    where(inactive_flag: false)
  end

  def self.superuser
    where(superuser_flag: true)
  end

  def ldap_entry
    UcbRails::LdapPerson::Finder.find_by_uid!(uid)
  end

  def full_name
    return nil unless first_name || last_name
    "#{first_name} #{last_name}".strip
  end

end
