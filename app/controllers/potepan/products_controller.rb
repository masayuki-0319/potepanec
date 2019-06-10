class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.friendly.find(params[:id])
    @related_products =
      @product.related_products.
        includes(master: [:default_price, :images]).
        shuffle.take(8)
  end
end
