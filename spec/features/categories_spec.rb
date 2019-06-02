require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  let(:taxonomy) { create(:taxonomy, name: 'test_taxonomy') }
  let(:taxon) { create(:taxon, name: 'test_taxon') }
  let(:product) { create(:product) }
  let(:other_taxonomy) { create(:taxonomy, name: 'test_other_taxonomy') }
  let(:other_taxon) { create(:taxon, name: 'test_ohter_taxon') }
  let(:other_product) { create(:product) }

  before do
    product.taxons << taxon
    taxonomy.root.children << taxon
    other_product.taxons << other_taxon
    other_taxonomy.root.children << other_taxon
  end

  scenario "商品カテゴリの表示を確認する。" do
    visit potepan_category_path(taxon_id: taxon.id)
    expect(page).to have_title taxon.name
    expect(page).to have_content product.name
    within('.side-nav') do
      expect(page).to have_content taxonomy.name
      expect(page).to have_content taxon.name
      expect(page).to have_content taxon.product_ids.count
      expect(page).to have_link taxon.name
      expect(page).to have_content other_taxonomy.name
      expect(page).to have_content other_taxon.name
      expect(page).to have_content other_taxon.product_ids.count
      expect(page).to have_link other_taxon.name
    end
  end

  scenario "商品カテゴリの画面間の移動を確認する。" do
    visit potepan_category_path(taxon_id: taxon.id)
    click_on other_taxon.name
    expect(current_path).to eq potepan_category_path(taxon_id: other_taxon.id)
  end

  scenario "商品カテゴリから商品詳細ページへの移動を確認する。" do
    visit potepan_category_path(taxon_id: taxon.id)
    click_on product.name
    expect(current_path).to eq potepan_product_path(product)
  end
end
