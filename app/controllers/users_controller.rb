class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def login
  end

  def post_login
    if params[:email] and params[:password] 
      @current_user = User.find_by(email: params[:email], password: Digest::SHA2.hexdigest(params[:password]))
      if @current_user
        session[:user_id] = @current_user.id
        if @current_user.mfa_enabled
          return redirect_to mfa_path 
        else 
          return redirect_to '/'
        end
      end
    end
    redirect_to login_path
  end

  def my
    
  end

  def post_register
    return redirect_to register_path unless params[:email] and params[:password]
    @user = User.find_by(email: params[:email])
    if @user
      flash[:error] = "User exists"
      return redirect_to '/register'
    else
      @user = User.create(email: params[:email], password: Digest::SHA2.hexdigest(params[:password]))
      redirect_to '/login'
    end
  end

  def register
  end

  def logout
    session[:user_id] = nil
    redirect_to '/login'
  end

  def password_reset
  end

  def post_password_reset
    user = User.find_by(email: params[:email])
    return redirect_to password_reset_path unless user
    link =  request.base_url+password_reset_with_code_path(code: code(user), email: user.email)
    UserMailer.password_reset_email(user, link).deliver_now 
    redirect_to login_path
  end

  def password_reset_with_code
    user = User.find_by(email: params[:email])
    return redirect_to password_reset_path unless user
    return redirect_to password_reset_path unless code(user) == params[:code]
     
  end
  
  def post_password_reset_with_code
    user = User.find_by(email: params[:email])
    return redirect_to password_reset_path unless user
    user.password =  Digest::SHA2.hexdigest(params[:password])
    user.save
    return redirect_to login_path
  end

  def toggle_mfa
    if @current_user.mfa_enabled 
      @current_user.mfa_enabled = false
    else
      @current_user.mfa_enabled = true
    end
    @current_user.save
  end 

  def mfa
    ret = @current_user.send_challenge 
    session[:mfa] = ret
  end
  
  def post_mfa
    if @current_user.verify(session[:mfa], params[:code]) 
      return redirect_to '/'
    else 
      return render 'mfa'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @current_user.update(user_params)
      redirect_to '/my', notice: 'User was successfully updated.' 
    else
      File.open('debug3','w').write  @current_user.errors 
      redirect_to '/my'
    end
  end

  def change_password
    if params[:password] and 
        params[:password_confirm] and 
        !params[:password].empty? and  
        params[:password]==params[:password_confirm]
      @current_user.password = Digest::SHA2.hexdigest(params[:password])
      @current_user.save
    else  
      flash['errors'] = "Invalid password or mismatch"
    end
    redirect_to '/my' 
  end
  # DELETE /users/1
  # DELETE /users/1.json

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :administrator, :phonenumber, :password_confirm)
    end

    def code(user)
      Digest::SHA2.hexdigest("T0D0S3CR3T"+user.email+"T0D0S3CR3T")
    end
end
