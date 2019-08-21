module Workarea
  module Storefront
    class CartBulkItemsController < ApplicationController
      include CheckInventory

      skip_before_action :verify_authenticity_token

      def create
        add_to_cart = AddMultipleCartItems.new(
          current_order,
          params[:items].map(&:to_unsafe_h).select { |p| p[:quantity].to_i.positive? }
        )

        if add_to_cart.perform!
          check_inventory
          Pricing.perform(current_order, current_shippings)

          @cart = CartViewModel.new(current_order, view_model_options)
          @items = add_to_cart.items.map do |cart_item|
            OrderItemViewModel.wrap(cart_item.item, view_model_options)
          end
        else
          flash[:error] =
            t('workarea.storefront.flash_messages.cart_bulk_items_error')
          redirect_to product_path(add_to_cart.items.first.product)
        end
      end
    end
  end
end
