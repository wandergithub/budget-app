require 'rails_helper'

RSpec.describe User, type: :model do
  context 'User model specs' do
    it 'is valid with valid attributes' do
      user = User.new(name: 'name 1', email: 'example@gmail.com', password: '123456778')
      expect(user).to be_valid
    end

    it 'expects a name attribute' do
      expect(User.new).to_not be_valid
    end
  end
end
