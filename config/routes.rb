Rails.application.routes.draw do
  resources :expense_reports
  get 'pages/home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  as :user do
    #root "devise/sessions#new"
  end

  # Defines the root path route ("/")
  # root "articles#index"
  resources :employees

  resources :expense_reports

  resources :expenses do
    resources :comments
    member do
      get :approve
      delete :reject
    end
  end
  resources :devise
  # get 'login',to: "devise/sessions#new"
  # root "employees#index"
  root "pages#home"
  
end
