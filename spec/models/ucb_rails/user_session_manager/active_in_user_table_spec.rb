require 'spec_helper'

describe UcbRails::UserSessionManager::ActiveInUserTable do
  let(:manager) { UcbRails::UserSessionManager::ActiveInUserTable.new }
  let(:user) { UcbRails::User.create!(ldap_uid: 1) }
  let(:last_user) { UcbRails::User.last! }

  describe "login" do

    context 'in ldap' do
      it "in User table" do
        user
        expect(manager.login("1")).to eq(last_user)
        expect(last_user.last_login_at).to be_within(1).of(Time.now)
      end

      it "inactive in User table" do
        user.update_attribute(:inactive_flag, true)
        expect(manager.login("1")).to be_falsey
      end

      it "not in User table" do
        expect(manager.login("1")).to be_falsey
      end
    end

    context 'not in ldap' do
      it "always false" do
        user
        expect(manager.login("100")).to be_falsey
      end
    end

  end

  describe '#current_user' do
    it "#current_user" do
      user
      expect(manager.current_user("1")).to eq(user)
    end

    it "blank" do
      [nil, ''].each do |ldap_uid|
        expect(manager.current_user(ldap_uid)).to be_nil
      end
    end
  end

end
