class UsersController < ApplicationController
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :authenticate_user, {only: [:index, :logout, :show, :edit, :update]}
  before_action :ensure_correct_user, {only: [:show, :edit, :update]}

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    if @user.save
      flash[:success] = "Anda berhasil mendaftar"
      redirect_to("/login")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if @user.save
      flash[:success] = "Profil berhasil diubah"
      redirect_to("/dashboard/#{@current_user.id}")
    else
      render("users/edit")
    end
  end
  
  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:success] = "Anda berhasil masuk"
      session[:user_id] = @user.id
      redirect_to("/dashboard/#{@user.id}")
    else
      @error_message = "Kombinasi email/password salah"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    flash[:success] = "Anda berhasil keluar"
    session[:user_id] = nil
    redirect_to("/")
  end

  def show
    @user = User.find_by(id: params[:id])
    @events = Event.all.order(created_at: :desc)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:danger] = "Akses dilarang"
      redirect_to("/dashboard/#{@current_user.id}")
    end
  end
end
