require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe '#show' do
    let!(:taxon) { create(:taxon) }
    let!(:another_taxon) { create(:taxon) }
    let!(:product) { create(:product, taxons: [taxon]) }
    let!(:related_products) { create_list(:product, 8, taxons: [taxon]) }
    let(:add_another_product) do
      create(:product, taxons: [another_taxon])
      get :show, params: { id: product.id }
    end
    let(:add_over_product) do
      create(:product, taxons: [taxon])
      get :show, params: { id: product.id }
    end

    before { get :show, params: { id: product.id } }

    it "レスポンス成功を確認" do
      expect(response).to be_successful
    end

    it "showテンプレートの描画を確認" do
      expect(response).to render_template :show
    end

    it "@productへの受け渡しを確認" do
      expect(assigns(:product)).to eq product
    end

    it "@related_productsへの受け渡しを確認" do
      add_another_product
      expect(assigns(:related_products)).to match_array related_products
    end

    it "@related_productsが商品を最大８個所有することを確認" do
      add_over_product
      expect(assigns(:related_products).size).to eq 8
    end
  end
end
