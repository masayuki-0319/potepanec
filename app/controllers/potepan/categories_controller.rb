class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find_by(id: params[:taxon_id])
    @products = @taxon.products
  end
end
