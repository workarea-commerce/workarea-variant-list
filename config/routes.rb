Workarea::Storefront::Engine.routes.draw do
  scope '(:locale)', constraints: Workarea::I18n.routes_constraint do
    resource :cart, only: [] do
      resource :bulk_items, only: :create, controller: :cart_bulk_items
    end
  end
end
