class HomeController < ApplicationController
  # GET /index
  def index
    if current_user.has_total_scope?
      @users = User.late_for_work.paginate(page: params[:page], per_page: 10).order('id DESC')
    else
      @attendances = current_user.attendances.paginate(page: params[:page], per_page: 10).order('check_in ASC')
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def not_working
    @users = User.not_working.paginate(page: params[:page], per_page: 10).order('id DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def attendances
    @user = User.find_by_id(params[:id])
    @attendances = @user.attendances.paginate(page: params[:page], per_page: 10).order('check_in ASC')
    respond_to do |format|
      format.html
      format.js
    end
  end
end
