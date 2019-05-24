require 'rails_helper'

RSpec.feature "Products", type: :feature do
  subject { product.taxons << taxon }

  let(:product) { create(:product) }
  let(:taxon) { create(:taxon) }

  scenario "ユーザーがProduct#showにアクセスする。" do
    visit potepan_product_path(product.id)
    within('.media-body') do
      expect(page).to have_title product.name
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end
  end

  scenario "ユーザーがCategoryを開く。" do
    subject
    expect(product.taxon_ids).to include(taxon.id)
    visit potepan_category_path(taxon.id)
    expect(page).to have_content product.name
  end
end
