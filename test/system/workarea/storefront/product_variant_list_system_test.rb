require 'test_helper'

module Workarea
  module Storefront
    class ProductVariantListSystemTest < Workarea::SystemTest
      def test_adding_skus_to_cart
        product = create_product(
          template: :variant_list,
          variants: [
            { sku: 'SKU1', regular: 5.to_m },
            { sku: 'SKU2', regular: 6.to_m },
            { sku: 'SKU3', regular: 7.to_m }
          ]
        )

        visit storefront.product_path(product)

        fill_in "quantity_catalog_variant_#{product.variants.first.id}", with: 3
        fill_in "quantity_catalog_variant_#{product.variants.second.id}", with: 2
        fill_in "quantity_catalog_variant_#{product.variants.third.id}", with: 1

        click_button 'add_to_cart'

        assert(page.has_content?('Success'))
        assert_text('$15.00')

        visit storefront.cart_path
        assert(page.has_content?(product.name))

        assert(page.has_content?(product.skus.first))
        assert(page.has_content?('$15.00'))

        assert(page.has_content?(product.skus.second))
        assert(page.has_content?('$12.00'))

        assert(page.has_content?(product.skus.third))
        assert(page.has_content?('$7.00'))
      end

      def test_sorting_variants
        product = create_product(
          template: :variant_list,
          variants: [
            { sku: 'FOOSKU', details: { color: 'red' }, regular: 7.to_m },
            { sku: 'BARSKU', details: { color: 'green' }, regular: 6.to_m },
            { sku: 'BAZSKU', details: { color: 'blue' }, regular: 5.to_m }
          ]
        )

        visit storefront.product_path(product)

        assert(page.has_ordered_text?('FOOSKU', 'BARSKU', 'BAZSKU'))
        assert(page.has_ordered_text?('red', 'green', 'blue'))
        assert(page.has_ordered_text?('7.00', '6.00', '5.00'))

        header = find('th', text: t('workarea.storefront.variant_list.products.sku'))

        header.click

        header.has_content?('↓')
        assert(page.has_ordered_text?('BARSKU', 'BAZSKU', 'FOOSKU'))
        assert(page.has_ordered_text?('green', 'blue', 'red'))
        assert(page.has_ordered_text?('6.00', '5.00', '7.00'))

        header.click

        header.has_content?('↑')
        assert(page.has_ordered_text?('FOOSKU', 'BAZSKU', 'BARSKU'))
        assert(page.has_ordered_text?('red', 'blue', 'green'))
        assert(page.has_ordered_text?('7.00', '5.00', '6.00'))

        header = find('th', text: 'Color')

        header.click

        header.has_content?('↓')
        assert(page.has_ordered_text?('BAZSKU', 'BARSKU', 'FOOSKU'))
        assert(page.has_ordered_text?('blue', 'green', 'red'))
        assert(page.has_ordered_text?('5.00', '6.00', '7.00'))

        header = find('th', text: t('workarea.storefront.variant_list.products.sku'))

        header.click
        header.click

        header.has_content?('↑')
        assert(page.has_ordered_text?('FOOSKU', 'BAZSKU', 'BARSKU'))
        assert(page.has_ordered_text?('red', 'blue', 'green'))
        assert(page.has_ordered_text?('7.00', '5.00', '6.00'))
      end
    end
  end
end
