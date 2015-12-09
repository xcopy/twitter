Rails.application.routes.draw do
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  devise_for :users,
    path: '',
    path_names: {
      sign_in: :login,
      sign_out: :logout,
      sign_up: :signup
    }

  # resources :users, path: '', only: [:show]
  # or:
  get '/:id', to: 'users#show', as: :user, constraints: {id: /[a-zA-Z0-9_.]+/}
end
