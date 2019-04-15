# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do 
    # FactoryBot.build(:user, username:) syntax is only if you don't include config line in rails helper
    create(:user) 
    #don't need to pass in a username or pw to the Faker b/c code in factories file populates the attributes. 
  end
  
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe 'uniqueness of username and session_token' do 
    before(:each) { create(:user) }

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end

  describe '#is_password?' do
    context 'with an invalid password' do
      it 'should return false' do
        expect(user.is_password?('fake')).to be false
      end
    end

    context 'with an valid password' do
      it 'should return true' do
        expect(user.is_password?('fakepassword')).to be true
      end
    end
  end

  describe '::find_by_credentials' do
    context 'with valid username and password' do
      it 'should return the correct user' do
        found_user = User.find_by_credentials(user.username, 'fakepassword')
        expect(found_user).to eq user
      end
    end
    
    context 'with invalid username and password' do
      it 'should not return the correct user' do
        found_user = User.find_by_credentials(user.username, 'password')
        expect(found_user).to_not eq user
      end
    end
  end

end
