class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:show, :edit_user, :update_user, :destroy, :change_user_password,
                                  :save_user_password]
  before_action :set_current_user, only: [:edit, :update, :change_password, :save_password]
  skip_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]
  skip_before_filter :require_no_authentication, only: [:new, :create, :cancel]
  skip_before_action :is_authorized, only: [:cancel, :edit, :update, :change_password, :save_password, :show]

  # GET /users
  # GET /users.json
  def index
    @users = policy_scope(User).paginate(page: params[:page], per_page: 15).order('id DESC')
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(sign_up_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_registrations_index_path, notice: t('notifications_masc.success.resource.created',
                                                                     resource: t('users.registrations.new.resource')) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  # PATCH/PUT /users/1
  def update
    prev_unconfirmed_email = @user.unconfirmed_email if @user.respond_to?(:unconfirmed_email)
    if @user.update_attributes(profile_update_params)
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ? :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      set_flash_message :notice, :updated
      sign_in @user, bypass: true
      redirect_to user_registration_path(@user)
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_registrations_index_path }
        format.json { head :no_content }
        flash[:notice] = t('notifications_masc.success.resource.destroyed',
                           resource: t('users.registrations.new.resource'))
      else
        format.html { render :index }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        flash_messages @user.errors.full_messages
      end
    end
  end

  # Allows a user to modify their own password.
  def change_password
  end

  # Allows a user to save their own password.
  def save_password
    respond_to do |format|
      if @user.update_with_password(profile_update_params) && @user.update(profile_update_params)
        # Sign in the user by passing validation in case their password changed
        sign_in @user, bypass: true
        format.html { redirect_to authenticated_root_path, notice: t('notifications_fem.success.resource.updated',
                                                                     resource: t('helpers.password')) }
        format.json { head :no_content }
      else
        format.html { render :change_password }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # Allows an administrator to edit other user.
  def edit_user
  end

  # Allows an administrator to update the information form other user.
  def update_user
    prev_unconfirmed_email = @user.unconfirmed_email if @user.respond_to?(:unconfirmed_email)
    if @user.update(account_update_params)
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ? :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      flash.now[:notice] = t('notifications_masc.success.resource.updated',
                             resource: t('users.registrations.new.resource'))
      redirect_to user_registrations_path
    else
      render 'edit_user'
    end
  end

  # Allows an administrator to change the password from other user.
  def change_user_password
  end

  # Allows an administrator to save the new password for the user.
  def save_user_password
    flag = true if @user.eql? current_user
    user = @user

    respond_to do |format|
      if @user.update(account_update_params)
        # Sign in the user by passing validation in case their password changed
        sign_in user, bypass: true if flag
        format.html { redirect_to users_registrations_index_path,
                                  notice: t('notifications_fem.success.resource.updated',
                                            resource: t('helpers.password')) }
        format.json { head :no_content }
      else
        format.html { render :change_user_password }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_current_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :mother_last_name,
                                 :role_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :mother_last_name,
                                 :role_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_update_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation, :first_name, :last_name,
                                 :mother_last_name)
  end
end
