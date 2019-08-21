$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "workarea/variant_list/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "workarea-variant_list"
  s.version     = Workarea::VariantList::VERSION
  s.authors     = ["Matt Duffy"]
  s.email       = ["mduffy@workarea.com"]
  s.homepage    = "https://github.com/workarea-commerce/workarea-variant-list"
  s.summary     = "Workarea Commerce Platform plugin that provides a variant list template for products."
  s.description = "Workarea Commerce Platform plugin that provides a variant list template for products."

  s.files = `git ls-files`.split("\n")

  s.license = 'Business Software License'

  s.add_dependency 'workarea', '~> 3.x', '>= 3.3.x'
end
