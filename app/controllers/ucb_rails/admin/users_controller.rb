class UcbRails::Admin::UsersController < UcbRails::Admin::BaseController
  before_filter :find_user, :only => [:edit, :update, :destroy]
  skip_before_filter :ensure_admin_user, only: :toggle_admin, if: ->{ Rails.env.development? }

  respond_to :html, :js


  def index
    respond_to do |format|
      format.html { @users = UcbRails::User.all }
      format.json { render json: UcbRails::UsersDatatable.new(view_context).as_json }
    end
  end

  def edit
  end

  def create
    uid = params.fetch(:uid)
    if user = UcbRails::User.find_by_ldap_uid(uid)
      flash[:warning] = "User already exists"
    else
      user = UcbRails::UserLdapService.create_user_from_uid(uid)
      flash[:notice] = 'Record created'
    end

    render :js => %(window.location.href = '#{edit_ucb_rails_admin_user_path(user)}')
  end

  def update
    if @user.update_attributes(ucb_rails_user_params)
      redirect_to(ucb_rails_admin_users_path, notice: 'Record updated')
    else
      render("edit")
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = 'Record deleted'
    else
      flash[:error] = @user.errors[:base].first
    end

    redirect_to(ucb_rails_admin_users_path)
  end

  def ldap_search
    # FIXME: this was retrofitted to support typeahead ajax json queries
    if(query = params[:query])
      @lps_entries = UcbRails::OmniUserTypeahead.new.ldap_results(query)
      @lps_entries.map!{|entry|
        attrs = entry.attributes.tap{|attrs| attrs["first_last_name"] = "#{attrs['first_name']} #{attrs['last_name']}" }
        attrs.as_json
      }

      render json: @lps_entries

    else
      @lps_entries = UcbRails::LdapPerson::Finder.find_by_first_last(
        params.fetch(:first_name),
        params.fetch(:last_name),
        :sort => :last_first_downcase
      )
      @lps_existing_uids = UcbRails::User.where(ldap_uid: @lps_entries.map(&:uid)).pluck(:uid)
      render 'ucb_rails/lps/search'
    end

  end

  def typeahead_search
    uta = UcbRails::UserTypeahead.new
    render json: uta.results(params.fetch(:query))
  end

  def omni_typeahead_search
    uta = UcbRails::OmniUserTypeahead.new
    render json: uta.results(params.fetch(:query))
  end

  def toggle_admin
    admin? ? current_user.update_column(:admin, false) : current_user.update_column(:admin, true)
    redirect_to root_path
  end

  private

  def ucb_rails_user_params
    params.require(:ucb_rails_user).permit(
      :admin,
      :inactive,
      :first_name,
      :last_name,
      :email,
      :alternate_email,
      :phone,
      :last_request_at,
      :last_logout_at,
      :last_login_at,
      :uid
    )
  end

  def find_user
    @user ||= UcbRails::User.find(params.fetch(:id))
  end

end
