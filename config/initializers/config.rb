Workarea.configure do |config|
  config.product_templates << :variant_list
  config.product_quickview_templates.try(:push, :variant_list)
end
