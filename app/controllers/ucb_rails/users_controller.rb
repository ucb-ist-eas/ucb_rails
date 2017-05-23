class UcbRails::UsersController < ApplicationController

  def search
    uta = UcbRails::UserTypeahead.new(first_last_name_column: params.fetch(:first_last_name_column), limit: params.fetch(:limit))
    render json: uta.results(params.fetch(:query))
  end

end
