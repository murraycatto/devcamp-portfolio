Rails.application.routes.draw do
  resources :blogs do
    member do
      get :toggel_status
    end
  end

  resources :portfolio_items, except:[:show]
  get 'portfolio_item/:id', to: 'portfolio_items#show', as: 'portfolio_item_show'
  get 'angular', to: 'portfolio_items#angular'

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  root to: 'pages#home'

end

# To search routes for a certain word
# ~ rake routes | grep keyword
