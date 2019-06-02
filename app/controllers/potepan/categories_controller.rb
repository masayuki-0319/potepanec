class Potepan::CategoriesController < ApplicationController
  before_action :view_type_select, only: [:show]

  def show
    @taxonomies = Spree::Taxonomy.eager_load(:root, taxons: :children).all
    @taxon = Spree::Taxon.find(params[:taxon_id])
    @products = @taxon.all_products.includes(master: [:default_price, :images])
  end

  private

  def view_type_select
    @view_type = params[:view_type] || 'Grid'
  end
end
