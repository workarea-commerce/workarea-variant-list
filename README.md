Workarea Variant List
================================================================================

A Workarea Commerce plugin that adds a product template for variant list display. With the variant list product template, the product detail page displays a grid of variants for the product, each variants options and price, and the ability to add any number of each variant to cart at the same time.

Getting Started
--------------------------------------------------------------------------------

Add the gem to your application's Gemfile:

```ruby
# ...
gem 'workarea-variant_list'
# ...
```

Update your application's bundle.

```bash
cd path/to/application
bundle
```

Caveats
--------------------------------------------------------------------------------

The list of plugins that this template is known to be incompatible with
includes, but not limited to:

- [BOPUS](https://plugins.workarea.com/plugins/bopus)
- [Subscriptions](https://plugins.workarea.com/plugins/subscriptions)
- [Product Bundles](https://plugins.workarea.com/plugins/product-bundles)
- [Wish Lists](https://plugins.workarea.com/plugins/wish-lists)

In the case that you have a plugin installed that is not compatible with
Variant Lists, you'll need to determine how the plugin is meant to
interact with products on a variant list template. On most projects,
you'll probably want to disable the interaction between the two plugins.
For example, here's how you'd disable adding to wish list on variant
list product templates by overriding **app/views/workarea/storefront/products/_add_to_wish_list.html.haml**:

```haml
- unless product.template == 'variant_list'
    .wish-list-button
      - if product.purchasable?
        = link_to users_wish_list_path, class: 'wish-list-button__link text-button', data: { wish_list_button: '', analytics: add_to_wish_list_analytics_data(product).to_json } do
          = t('workarea.storefront.wish_lists.add_to_wish_list')
```

Workarea Commerce Documentation
--------------------------------------------------------------------------------

See [https://developer.workarea.com](https://developer.workarea.com) for Workarea Commerce documentation.

License
--------------------------------------------------------------------------------

Workarea Variant List is released under the [Business Software License](LICENSE)
