require 'spec_helper'

describe UcbRails::UserSessionManager::InPeopleOuAddToUsersTable do
  let(:manager) { UcbRails::UserSessionManager::InPeopleOuAddToUsersTable.new }
  let(:user) { UcbRails::User.create!(uid: 1) }
  
  describe '#login' do
    
    describe 'in People OU' do
      it "in User table" do
        user
        manager.login("1").should == UcbRails::User.last
      end
      
      it 'not in User table' do
        manager.login("1").should == UcbRails::User.last
      end
    end
    
    describe 'not in People OU' do
      it "always false" do
        UcbRails::User.create!(uid: 100)
        manager.login("100").should be_falsey
      end
    end
    
  end
  
  describe '#current_user' do
    it "returns user" do
      user
      manager.current_user("1").should == user
    end
    
    it "handles nil" do
      manager.current_user(nil).should be_nil
    end
  end
  
end