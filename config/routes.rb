Rails.application.routes.draw do
  get "/copy", to: "copy#index"
  post "/copy/refresh", to: "copy#refresh"
  get "/copy/:id", to: "copy#show", constraints: { id: /[^\/?]+/ }
end
