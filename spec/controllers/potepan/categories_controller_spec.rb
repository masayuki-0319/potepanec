require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe '#show' do
    subject do
      product.taxons << taxon
      other_product.taxons << taxon
      get :show, params: { taxon_id: taxon.id }
    end

    let(:taxon) { create(:taxon) }
    let(:taxonomy) { create(:taxonomy) }
    let(:product) { create(:product) }
    let(:other_product) { create(:product) }
    let(:another_product) { create(:product) }

    it "レスポンス成功を確認" do
      subject
      expect(response).to be_successful
    end

    it "showテンプレートの描画を確認" do
      subject
      expect(response).to render_template :show
    end

    it "@taxonへの受け渡しを確認" do
      subject
      expect(assigns(:taxon)).to eq(taxon)
    end

    it "@taxonomiesへの受け渡しを確認" do
      subject
      expect(assigns(:taxonomies)).to include(taxonomy)
    end

    it "@productsへの受け渡しを確認" do
      subject
      expect(assigns(:products)).to include(product, other_product)
      expect(assigns(:products)).not_to include(another_product)
    end
  end
end
