require 'rails_helper'

RSpec.feature "Products", type: :feature do
  subject do
    product.taxons << taxon
    taxonomy.root.children << taxon
  end

  let(:product) { create(:product) }
  let(:taxon) { create(:taxon) }
  let(:taxonomy) { create(:taxonomy) }

  scenario "商品個別ページにアクセスする。" do
    visit potepan_product_path(product.id)
    within('.media-body') do
      expect(page).to have_title product.name
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end
  end

  scenario "カテゴリーから商品個別ページでアクセスする。" do
    subject
    visit potepan_category_path(taxon_id: taxon.id, view_type: 'Grid')
    expect(page).to have_title taxon.name
    expect(page).to have_content product.name
    within('.side-nav') do
      expect(page).to have_content taxonomy.name
      expect(page).to have_content taxonomy.taxons.first.name
      expect(page).to have_content taxon.name
      expect(page).to have_content taxon.product_ids.count
    end
    click_on product.name
    within('.media-body') do
      expect(page).to have_title product.name
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end
  end
end
