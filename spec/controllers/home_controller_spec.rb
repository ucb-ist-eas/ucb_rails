require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "#index" do
    it "renders the not_logged_in template if the user is not logged in" do
      get :index
      expect(subject).to render_template(:not_logged_in)
    end

    it "renders the logged_in template if the user is not logged in" do
      allow(subject).to receive(:logged_in?) { true }
      get :index
      expect(subject).to render_template(:logged_in)
    end
  end

end
