class Potepan::CategoriesController < ApplicationController
  before_action :view_type_select, only: [:show]

  def show
    @taxonomies = Spree::Taxonomy.eager_load(:root, taxons: :children).all
    @taxon = Spree::Taxon.find_by(id: params[:taxon_id])
    @products = @taxon.all_products.includes(master: [:default_price, :images])
  end

  private

  # Viewの表示において，GridとListの切り替え処理に使用する。
  def view_type_select
    @view_type = params[:view_type] ||= 'Grid'
  end
end
