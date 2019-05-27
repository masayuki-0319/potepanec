require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  subject do
    product.taxons << taxon
    taxonomy.root.children << taxon
    other_product.taxons << other_taxon
    other_taxonomy.root.children << other_taxon
  end

  let(:product) { create(:product) }
  let(:taxon) { create(:taxon) }
  let(:taxonomy) { create(:taxonomy) }
  let(:other_product) { create(:product) }
  let(:other_taxon) { create(:taxon) }
  let(:other_taxonomy) { create(:taxonomy) }

  scenario "商品カテゴリーの表示を確認する。" do
    subject
    visit potepan_category_path(taxon_id: taxon.id, view_type: 'Grid')
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
end
