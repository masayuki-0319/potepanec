require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe '#show' do
    subject { get :show, params: { id: product.id } }

    let(:product) { FactoryBot.create(:product) }

    it "レスポンスの確認" do
      subject
      expect(response).to be_successful
    end

    it "View表示の確認" do
      subject
      expect(response).to render_template :show
    end

    it "インスタンスの確認" do
      subject
      expect(assigns(:product)).to eq(product)
    end
  end
end
