class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.friendly.find(params[:id])
    taxon = Spree::Taxon.find(@product.taxon_ids.first)
    products = taxon.all_products.includes(master: [:default_price, :images])
    @products = products.reject { |p| p == @product }
  end
end
