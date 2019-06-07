require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe '#show' do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let!(:other_product) { create(:product, taxons: [taxon]) }

    before { get :show, params: { id: product.id } }

    it "レスポンス成功を確認" do
      expect(response).to be_successful
    end

    it "showテンプレートの描画を確認" do
      expect(response).to render_template :show
    end

    it "@productへの受け渡しを確認" do
      expect(assigns(:product)).to eq(product)
    end

    it "@productsへの受け渡しを確認" do
      expect(assigns(:products)).to eq [other_product]
    end
  end
end
