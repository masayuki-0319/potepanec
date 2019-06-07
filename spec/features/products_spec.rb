require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let!(:taxon) { create(:taxon) }
  let!(:product) { create(:product, taxons: [taxon]) }
  let!(:other_product) { create(:product, taxons: [taxon]) }

  background do
    visit potepan_product_path(product.id)
  end

  scenario "商品詳細にアクセスする。" do
    within('.media-body') do
      expect(page).to have_title product.name
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end
  end

  scenario "商品詳細からカテゴリページへアクセスする。" do
    click_on '一覧ページへ戻る'
    expect(page).to have_title taxon.name
    expect(page).to have_content product.name
  end

  scenario "関連商品の表示とリンクを確認する。" do
    within('.productBox') do
      expect(page).to have_content other_product.name
      expect(page).to have_content other_product.display_price
      expect(find('a')[:href]).to eq potepan_product_path(other_product)
    end
  end

  scenario "関連商品にアクセスする。" do
    click_on other_product.name
    within('.productBox') do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
    end
  end
end
