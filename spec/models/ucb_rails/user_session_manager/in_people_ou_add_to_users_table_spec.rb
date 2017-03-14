require 'spec_helper'

describe UcbRails::UserSessionManager::InPeopleOuAddToUsersTable do
  let(:manager) { UcbRails::UserSessionManager::InPeopleOuAddToUsersTable.new }
  let(:user) { UcbRails::User.create!(ldap_uid: 1) }

  describe '#login' do

    describe 'in People OU' do
      it "in User table" do
        user
        expect(manager.login("1")).to eq(UcbRails::User.last)
      end

      it 'not in User table' do
        expect(manager.login("1")).to eq(UcbRails::User.last)
      end
    end

    describe 'not in People OU' do
      it "always false" do
        UcbRails::User.create!(ldap_uid: 100)
        expect(manager.login("100")).to be_falsey
      end
    end

  end

  describe '#current_user' do
    it "returns user" do
      user
      expect(manager.current_user("1")).to eq(user)
    end

    it "handles nil" do
      expect(manager.current_user(nil)).to be_nil
    end
  end

end
