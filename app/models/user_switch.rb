class UserSwitch < ActiveRecord::Base

  belongs_to :switchee, class_name: "User", primary_key: "ldap_uid", foreign_key: "switch_uid"

  def switchee_name
    switchee.try(:first_last_name) || switch_uid
  end

  def self.recent_for(uid)
    users = self
      .where(uid: uid)
      .where("switch_uid != ?", uid)
      .where("created_at > ?", 1.week.ago)
      .uniq
      .limit(5)
      .order("created_at desc")
      .includes(:switchee)
  end

  def self.all_for(uid)
    self
      .includes(:switchee)
      .where(uid: uid)
      .order("created_at desc")
  end

end
