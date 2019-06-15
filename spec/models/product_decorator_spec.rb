require 'rails_helper'

RSpec.describe Potepan::ProductDecorator, type: :model do
  let!(:taxon) { create(:taxon) }
  let!(:other_taxon) { create(:taxon) }
  let!(:another_taxon) { create(:taxon) }
  let!(:product) { create(:product, taxons: [taxon, other_taxon]) }
  let!(:first_other_product) { create(:product, taxons: [taxon]) }
  let!(:second_other_product) { create(:product, taxons: [other_taxon]) }
  let!(:another_product) { create(:product, taxons: [another_taxon]) }

  describe '#related_products' do
    it '同じカテゴリの商品のみ返す' do
      expect(product.related_products).to match_array [first_other_product, second_other_product]
    end
  end
end
