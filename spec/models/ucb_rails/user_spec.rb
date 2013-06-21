require 'spec_helper'

describe UcbRails::User do
  let(:klass) { UcbRails::User }
  
  it "#roles defaults to []" do
    klass.new.roles.should == []
  end
  
  it "#has_role?" do
    user = klass.new
    user.should_not have_role('foo')
    
    user.stub :roles => ['foo']
    user.should have_role('foo')
  end
  
  it 'first_last_name' do
    klass.create!(uid: 1).first_last_name.should be_nil
    klass.create!(uid: 2, first_name: 'Art').first_last_name.should == 'Art'
    klass.create!(uid: 3, last_name: 'Andrews').first_last_name.should == 'Andrews'
    klass.create!(uid: 4, first_name: 'Art', last_name: 'Andrews').first_last_name.should == 'Art Andrews'
  end
  
  it '#admin!' do
    user = UcbRails::User.create!(uid: 1)
    user.should_not be_admin
    
    user.admin!
    user.should be_admin

    user.admin!(false)
    user.should_not be_admin
  end
  
  it "active?" do
    user = UcbRails::User.create!(uid: 1)
    user.should_not be_inactive
    user.should be_active
  end
  
  it '#inactive!' do
    user = UcbRails::User.create!(uid: 1)
    user.should_not be_inactive
    
    user.inactive!
    user.should be_inactive
    
    user.inactive!(false)
    user.should_not be_inactive
  end
  
  it '.active' do
    active = UcbRails::User.create(uid: 1)
    inactive = UcbRails::User.create(uid: 2, inactive: true)
    UcbRails::User.active.should == [active]
  end

  it '.admin' do
    admin = UcbRails::User.create(uid: 1)
    admin.admin!
    not_admin = UcbRails::User.create(uid: 2)
    UcbRails::User.admin.should == [admin]
  end
end