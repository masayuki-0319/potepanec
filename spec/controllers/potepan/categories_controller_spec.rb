require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe '#show' do
    subject { get :show, params: { id: taxon.id } }

    let(:taxon) { create(:taxon) }

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
  end
end
