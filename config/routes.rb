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

  get :who_to_follow, to: 'users#who_to_follow'

  resource :users, only: [] do
    member do
      post :follow, :unfollow
    end
  end

  constraints(id: /[a-zA-Z0-9_.]+/) do
    resources :users, path: '', only: [:show] do
      member do
        get :following, :followers
      end

      resources :statuses, only: [:show, :create], constraints: {id: /\d+/}
    end
  end

  # or:
  # get '/:id', to: 'users#show', as: :user, constraints: {id: /[a-zA-Z0-9_.]+/}
end
