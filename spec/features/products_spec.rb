require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let(:product) { create(:product) }

  scenario "ユーザーがProduct詳細ページまでアクセスする。" do
    visit potepan_root_path
    expect(page).to have_title "BIGBAG Store"
    click_link "View Shirts"
    expect(page).to have_content "Product Grid Sidebar Left"
    click_link product.name
    expect(page).to have_content "product.name"
  end
end
