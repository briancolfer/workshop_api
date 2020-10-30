# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  mount Rswag::Ui::Engine, at: '/api-docs'
  mount Rswag::Api::Engine, at: '/api-docs'
  devise_for :users, path: '',
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
             },
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  resources :people
  resources :workshops

end
