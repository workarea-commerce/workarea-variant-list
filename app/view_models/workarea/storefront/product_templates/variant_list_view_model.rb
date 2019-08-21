module Workarea
  module Storefront
    class ProductTemplates::VariantListViewModel < ProductViewModel
      delegate :all_options, to: :option_set

      def variant_list
        @variant_list ||= variants.map do |variant|
          VariantViewModel.new(
            variant,
            options.merge(inventory: inventory)
          )
        end
      end

      def option_set
        @option_set ||= ProductViewModel::OptionSet.new(self, options)
      end
    end
  end
end
