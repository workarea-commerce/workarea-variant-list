module Workarea
  module VariantList
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::VariantList
    end
  end
end
