require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'Product Controller' do
    it "responds successfully" do
      expect(response).to be_success
    end

    # it "responds 'show' template " do
    #   expect(response).to render_template :show
    # end
  end
end
