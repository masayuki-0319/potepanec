require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe '#show' do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:other_product) { create(:product, taxons: [taxon]) }

    before { get :show, params: { taxon_id: taxon.id } }

    it "レスポンス成功を確認" do
      expect(response).to be_successful
    end

    it "showテンプレートの描画を確認" do
      expect(response).to render_template :show
    end

    it "@taxonへの受け渡しを確認" do
      expect(assigns(:taxon)).to eq(taxon)
    end

    it "@taxonomiesへの受け渡しを確認" do
      expect(assigns(:taxonomies)).to eq [taxonomy]
    end

    it "@productsへの受け渡しを確認" do
      expect(assigns(:products)).to eq [product, other_product]
    end

    it "@view_typeへの受け渡しを確認" do
      expect(assigns(:view_type)).to eq('Grid')
      get :show, params: { taxon_id: taxon.id, view_type: 'List' }
      expect(assigns(:view_type)).to eq('List')
    end
  end
end
