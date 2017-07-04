Rails.application.routes.draw do
  resources :permissions do
    collection do
      get :get_controller_actions
      post :generate_seeds
    end
  end

  resources :roles do
    member do
      get :role_permissions
      post :assign_permissions
    end
  end

  devise_for :users,
             controllers: {sessions: 'users/sessions',
                           confirmations: 'users/confirmations',
                           unlocks: 'users/unlocks',
                           registrations: 'users/registrations',
                           passwords: 'users/passwords',
                           password_expired: 'users/password_expired'},
             path: '/',
             path_names: {sign_in: 'login',
                          sign_out: 'logout'}

  devise_scope :user do
    # Redirect to the authenticated path if the user is authenticated.
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    # Redirect to the unauthenticated path if the user is unauthenticated.
    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end

    namespace :users do
      namespace :registrations do
        get :index
        get :new
        post :create
        get :edit
        match :update, via: [:patch, :put]
        get 'update/:id/edit', action: :edit_user
        match 'update/:id', action: :update_user, via: [:patch, :put]
        get :change_password
        match :save_password, via: [:patch, :put]
        get 'users/:id/change_password', action: :change_user_password, via: [:patch, :put], as: :change_user_password
        match 'save_password/:id', action: :save_user_password, via: [:patch, :put]
        get 'users/:id', action: :show, as: :show
        delete 'destroy/:id', action: :destroy, as: :destroy
      end
    end

    # Allows the execution of the back button in the login options.
    get '/login', to: 'devise/seasons#new'
  end
end
