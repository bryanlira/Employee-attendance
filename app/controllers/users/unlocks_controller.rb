class Users::UnlocksController < Devise::UnlocksController
  skip_before_action :is_authorized
  layout 'out_system'
  # GET /resource/unlock/new
  def new
    super
  end

  # POST /resource/unlock
  def create
    super
  end

  # GET /resource/unlock?unlock_token=abcdef
  def show
    super
  end
end

