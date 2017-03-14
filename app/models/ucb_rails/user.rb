class UcbRails::User < ActiveRecord::Base
  self.table_name = 'users'

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

  def inactive
    warn "inactive is deprecated - please use inactive?"
    inactive_flag
  end

  def admin
    warn "admin is deprecated - please use superuser"
    superuser_flag
  end

  def admin?
    warn "admin? is deprecated - please use superuser?"
    superuser?
  end

  def admin!(_admin=true)
    warn "admin! is deprecated - please use superuser!"
    superuser!(_admin)
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

  def self.admin
    warn "User.admin is deprecated - please use User.superuser"
    self.superuser
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

  def first_last_name
    warn "first_last_name is deprecated - please use full_name"
    full_name
  end

  def uid
    warn "uid is deprecated - please use ldap_uid"
    ldap_uid
  end

end
