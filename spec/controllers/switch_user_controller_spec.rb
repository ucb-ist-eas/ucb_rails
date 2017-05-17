require "rails_helper"

RSpec.describe Admin::SwitchUserController, type: :controller do
  let!(:orig_user) { create(:superuser) }
  let!(:fake_user) { create(:user) }
  before { login_user(orig_user) }

  it "#index shows recent switches" do
    switch = create(:user_switch, uid: orig_user.ldap_uid)
    get :index
    expect(response).to be_success
    expect(assigns[:recent_switches]).to eq([switch])
    expect(assigns[:all_switches]).to eq([switch])
  end

  it "can log in user as a different user" do
    post :switch_user, uid: fake_user.ldap_uid
    expect(response).to redirect_to(admin_switch_user_path)
    expect(flash[:success]).to eq("Switched to #{fake_user.full_name}")
    expect(subject.current_user(true)).to eq(fake_user)
  end

  it "can switch user back to their original login" do
    post :switch_user, uid: fake_user.ldap_uid
    expect(subject.current_user(true)).to eq(fake_user)
    post :switch_back, {}
    expect(response).to redirect_to(admin_switch_user_path)
    expect(flash[:success]).to eq("Switched back to #{orig_user.full_name}")
    expect(subject.current_user(true)).to eq(orig_user)
  end

  it "shows an error if no user was selected" do
    post :switch_user, uid: nil
    expect(response).to redirect_to(admin_switch_user_path)
    expect(flash[:error]).to eq("Select a user.")
  end

  it "redirects to the logout path if user tries to switch back before switching" do
    post :switch_back, {}
    expect(response).to redirect_to(logout_path)
  end

end
