class HomeController < ApplicationController
  include UcbRailsControllerMethods

  skip_before_filter :ensure_authenticated_user

  def index
    if logged_in?
      render "logged_in"
    else
      render "not_logged_in"
    end
  end

end

