module Shop
  module Services
    module CartItems
      RSpec.describe Fetch do
        include_context 'shared global state stubs'

        describe '#call' do
          shared_examples 'raises CartItems::CartItemDoesNotExistError' do |product_id|
            it 'raises CartItems::CartItemDoesNotExistError' do
              expect { Fetch.new.call(product_id: product_id) }
                .to raise_error(CartItems::CartItemDoesNotExistError)
            end
          end

          context 'with a nil id' do
            include_examples 'raises CartItems::CartItemDoesNotExistError', nil
          end

          context "with a non-existant Product's id" do
            include_examples 'raises CartItems::CartItemDoesNotExistError', -1
          end

          context "with an existing Product's id that's not in the cart" do
            include_examples 'raises CartItems::CartItemDoesNotExistError', 6 # not_in_cart_product.id
          end

          context 'with a valid id' do
            it 'returns the Models::CartItem requested' do
              expect(Fetch.new.call(product_id: in_cart_product.id))
                .to eq(cart_item)
            end
          end
        end
      end
    end
  end
end
