Rails.application.routes.draw do
  get '/home', to: 'index#index'
  get '/about', to: 'index#about'
  get '/faq', to: 'index#faq'
  get '/issue', to: 'index#issue'
  get '/help', to: 'index#help'
  get 'admin', to: 'index#admin'
  
  namespace :admin do
    resources :documents, only: [:index, :destroy, :show, :edit, :update] do
      member do 
        get 'approve'
      end
    end
    resources :attendances, only: [:index]
    resources :leaves, only: [:index, :destroy, :show, :edit, :update], as: "leave" do
      member do
        get 'recommend'
        patch 'change'
        put 'change'
      end
    end
    resources :leaves, only: [:index, :destroy, :show, :edit, :update], as: "leaves" do
      member do
        get 'recommend'
        patch 'change'
        put 'change'
      end
    end

    resources :employees, only: [:index, :destroy, :show, :edit, :update] do
      member do
        get 'recruit'
      end
    end
  end
  resources :documents
  scope(path_names: { new: 'status'}) do
    resources :attendances, only: [:index, :new, :create]
  end
  resources :sessions, only: [:index, :destroy, :create] do
    collection do
      delete 'destroy_all'
    end
  end
  resources :leaves, as: "leave"
  resources :leaves, as: "leaves"
  resources :employees, only: [:new, :create, :destroy, :show, :edit, :update] do # show
	  collection do
	    get 'login'
	  end
	end
  get "me", to: "employees#show", id: "me"
  post "employees/login", to: "sessions#create"

  root "index#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
