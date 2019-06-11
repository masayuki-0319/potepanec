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

    context "@productがTaxonsを持つ時" do
      it "taxon_idは，productのTaxonを持つ" do
        expect(assigns(:taxon_id)).to eq product.taxons.first.id
      end
    end

    context "@productがTaxonsを持たない時" do
      before do
        product.taxons = []
        get :show, params: { id: product.id }
      end

      it "taxon_idは，Spree::Taxon.firstを持つ" do
        expect(assigns(:taxon_id)).to eq Spree::Taxon.first.id
      end
    end

    context "同じTaxonに属する商品が存在する時" do
      before { create(:product, taxons: [taxon]) }

      it "@related_productは，関連商品を最大８個持つ" do
        expect(assigns(:related_products).size).to eq 8
      end
    end

    context "別のTaxonに属する商品が存在する時" do
      let(:another_taxon) { create(:taxon) }

      before { create(:product, taxons: [another_taxon]) }

      it "@related_productは，同じTaxonを持つ商品のみ持つ" do
        expect(assigns(:related_products)).to match_array related_products
      end
    end
  end
end
