require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.new(name: 'name 1') }

  context 'Group model examples' do
    it 'requires a name to be valid' do
      expect(Group.new( user:)).to_not be_valid
    end

    it 'belongs to a user to be valid' do
      expect(Group.new(name: 'sample 1')).to_not be_valid
    end

    it 'is valid with the right attributes' do
      expect(Group.new(name: 'group 1', user:)).to be_valid
    end
  end
end