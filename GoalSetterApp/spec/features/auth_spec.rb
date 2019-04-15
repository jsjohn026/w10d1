require 'spec_helper'
require 'rails_helper'

feature 'the signup process', type: :feature do
  before(:each) do
    user = create(:user)
    login_user(user)
    visit new_user_url
  end
  
  scenario 'has a new user page' do 
    expect(page).to have_content("Sign Up")
  end
  
  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do 
      visit users_url
      expect(page).to have_content(User.last.username)
    end
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do 
    user = create(:user)
    login_user(user)
    expect(page).to have_content(user.username)
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state'

  scenario 'doesn\'t show username on the homepage after logout'

end