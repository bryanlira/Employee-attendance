class Users::ConfirmationsController < Devise::ConfirmationsController
  layout 'out_system'
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
  end
end
