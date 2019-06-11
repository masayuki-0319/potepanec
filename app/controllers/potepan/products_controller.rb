class Potepan::ProductsController < ApplicationController
  DISPLAY_RELATED_PRODUCTS_NUMBER = 8

  def show
    @product = Spree::Product.friendly.find(params[:id])
    @related_products =
      @product.related_products.
        includes(master: [:default_price, :images]).
        shuffle.take(DISPLAY_RELATED_PRODUCTS_NUMBER)
  end
end
