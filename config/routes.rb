Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 root to: 'api/flows#index'
 namespace :api do
  
  resource :flow 
  get "flow_doc/list", to: "flows#get_list"
 end
end
