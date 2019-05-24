class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find_by(id: params[:taxon_id])
    @products = @taxon.products
    render template: "potepan/sample/product_grid_left_sidebar"
  end
end
