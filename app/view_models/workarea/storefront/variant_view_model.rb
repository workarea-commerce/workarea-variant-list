module Workarea
  module Storefront
    class VariantViewModel < ApplicationViewModel
      delegate :inventory_status, :images, :primary_image, :inventory,
        :inventory_purchasable?, :pricing, to: :product

      def product
        @product ||=
          ProductViewModel.wrap(model.product, options.merge(sku: sku))
      end

      def details
        @details ||= Hash[
          model.details.map { |k, v| [k.to_s.optionize, [v].flatten.join(', ')] }
        ]
      end

      def price
        @price ||= pricing.for_sku(sku)
      end

      def purchasable?
        product.model.purchasable? && inventory_purchasable? && price.persisted?
      end
    end
  end
end
