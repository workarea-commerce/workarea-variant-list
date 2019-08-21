require 'test_helper'

module Workarea
  module Storefront
    class CartBulkItemsIntegrationTest < Workarea::IntegrationTest
      include CatalogCustomizationTestClass

      def test_create
        product = create_product(
          template: :variant_list,
          variants: [
            { sku: 'SKU1', regular: 5.to_m },
            { sku: 'SKU2', regular: 6.to_m },
            { sku: 'SKU3', regular: 7.to_m }
          ]
        )

        create_inventory(id: 'SKU2', policy: :standard, available: 2)

        post storefront.cart_bulk_items_path,
             xhr: true,
             params: {
               items: [
                 { sku: 'SKU1', quantity: 1, product_id: product.id },
                 { sku: 'SKU2', quantity: 3, product_id: product.id },
                 { sku: 'SKU3', quantity: 0, product_id: product.id }
               ]
             }

        assert(response.ok?)
        assert(flash[:error].present?)

        order = Order.first
        assert_equal(2, order.items.count)

        item = order.items.where(sku: 'SKU1').first
        assert_equal(1, item.quantity)
        assert(item.product_attributes.present?)

        item = order.items.where(sku: 'SKU2').first
        assert_equal(2, item.quantity)
        assert(item.product_attributes.present?)
      end

      def test_does_not_any_items_when_customizations_are_invalid
        product = create_product(
          template: :variant_list,
          customizations: 'foo_cust',
          variants: [
            { sku: 'SKU1', regular: 5.to_m },
            { sku: 'SKU2', regular: 6.to_m },
            { sku: 'SKU3', regular: 7.to_m }
          ]
        )

        post storefront.cart_bulk_items_path,
             xhr: true,
             params: {
               product_id: product.id,
               items: [
                 { sku: 'SKU1', quantity: 1, foo: 'test' },
                 { sku: 'SKU2', quantity: 3, foo: 'test', bar: 'test' },
                 { sku: 'SKU3', quantity: 0 }
               ]
             }

        assert_redirected_to(storefront.product_path(product))
        assert(flash[:error].present?)
        assert_equal(0, Order.count)
      end
    end
  end
end
