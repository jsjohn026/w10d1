require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) do 
    create(:user)
  end

  describe 'GET #index' do 
    it 'should render the users index template' do 
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do 
    it "should render the user's show page" do 
      allow(subject).to receive(:logged_in?).and_return(true)
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end
end
