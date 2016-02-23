class UcbRails::UsersController < ApplicationController
  
  def search
    uta = UcbRails::UserTypeahead.new
    render json: uta.results(params.fetch(:query))
  end
    
end