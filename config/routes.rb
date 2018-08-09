Rails.application.routes.draw do
  resources :storedfiles, path: :files
  resources :todos
  resources :users

  get 'my'      => 'users#my', as: 'my'
  post 'change_password'      => 'users#change_password', as: 'change_password'
  get 'register'  => 'users#register', as: 'register'
  post 'register'  => 'users#post_register', as: 'post_register'
 
  get 'login'  => 'users#login', as: 'login'
  post 'login'  => 'users#post_login', as: 'post_login'
  
  get 'logout'  => 'users#logout', as: 'logout'

  get 'reset_password'  => 'users#password_reset', as: 'password_reset'
  post 'reset_password'  => 'users#post_password_reset', as: 'post_password_reset'

  get 'password/reset/:code' => 'users#password_reset_with_code',  as: 'password_reset_with_code'
  post 'password/reset/:code' => 'users#post_password_reset_with_code',  as: 'post_password_reset_with_code'
  
  get 'mfa/toggle' => 'users#toggle_mfa', as: 'toggle_mfa'

  get 'mfa' => 'users#mfa', as: 'mfa'
  post 'mfa'=> 'users#post_mfa', as: 'post_mfa'


  scope module: 'admin' do
      get  "admin" => "admin_welcome#index", as: 'admin_root'
      resources :admin_users
#      get  "admin/users" => "admin_users#index", as: 'admin_users'
  end

  root 'todos#index' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
