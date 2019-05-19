require 'rails_helper'

RSpec.feature "Products", type: :feature do
  before { FactoryBot.create(:product, name: "Test", price: 189, description: "description") }
  scenario "ユーザーがProduct詳細ページまでアクセスする。" do
    visit potepan_root_path
    expect(page).to have_title "BIGBAG Store"
    click_link "View Shirts"
    expect(page).to have_content "Product Grid Sidebar Left"
    click_link "Test"
    expect(page).to have_content "Test"
    expect(page).to have_content 189
    expect(page).to have_content "description"
  end
end
