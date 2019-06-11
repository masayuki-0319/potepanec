require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe '#show' do
    let!(:taxon) { create(:taxon) }
    let!(:product) { create(:product, taxons: [taxon]) }
    let!(:related_products) { create_list(:product, 8, taxons: [taxon]) }

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

    context "@related_productsへの受け渡しを確認" do
      let(:another_taxon) { create(:taxon) }

      before do
        create(:product, taxons: [taxon])
        create(:product, taxons: [another_taxon])
      end

      it "同じTaxonに属する商品が存在する時" do
        expect(assigns(:related_products).size).to eq 8
      end

      it "別のTaxonに属する商品が存在する時" do
        expect(assigns(:related_products)).to match_array related_products
      end
    end
  end
end
