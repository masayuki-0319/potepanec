class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.friendly.find(params[:id])
    products = related_products(@product).includes(master: [:default_price, :images])
    @related_products = products.shuffle.take(8)
  end

  private

  def related_products(product)
    Spree::Product.in_taxons(product.taxons).where.not(id: product.id).distinct
  end
end
