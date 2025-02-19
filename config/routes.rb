Rails.application.routes.draw do
  scope "(:locale)", locale: /ja|en/ do
    resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  end
end
