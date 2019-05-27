require 'rails_helper'

RSpec.feature "Products", type: :feature do
  subject { product.taxons << taxon }

  let(:taxon) { create(:taxon) }
  let(:product) { create(:product) }

  scenario "商品個別ページにアクセスする。" do
    subject
    visit potepan_product_path(product.id)
    within('.media-body') do
      expect(page).to have_title product.name
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end
  end
end
