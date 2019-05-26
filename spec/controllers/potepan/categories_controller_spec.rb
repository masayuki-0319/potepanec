require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe '#show' do
    subject { get :show, params: { taxon_id: taxon.id } }

    let(:taxon) { create(:taxon) }
    let(:taxonomy) { create(:taxonomy) }

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
  end
end
