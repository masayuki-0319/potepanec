class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.all
    @taxon = Spree::Taxon.find_by(id: params[:taxon_id])
    @products = @taxon.all_products
    params[:view_type] ||= 'Grid'
  end
end
