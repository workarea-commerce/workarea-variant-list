require 'workarea/testing/teaspoon'

Teaspoon.configure do |config|
  config.root = Workarea::VariantList::Engine.root
  Workarea::Teaspoon.apply(config)
end
