require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe '#show' do
    subject { get :show, params: { id: product.id } }

    let(:product) { FactoryBot.create(:product) }

    it "レスポンス成功を確認" do
      subject
      expect(response).to be_successful
    end

    it "showテンプレートの描画を確認" do
      subject
      expect(response).to render_template :show
    end

    it "@productへの受け渡しを確認" do
      subject
      expect(assigns(:product)).to eq(product)
    end
  end
end
