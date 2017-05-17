class Admin::BaseController < ApplicationController
  include UcbRailsControllerMethods
  before_filter :ensure_admin_user

end
