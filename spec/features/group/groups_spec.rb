require 'rails_helper'

RSpec.describe 'Group pages integration examples', type: :feature do
  # New user
  let(:user) { User.create(name: "example 1", password: "pasword11212", email: "email@exmaple.com") }
  
  
  before(:each) do
    # Log in
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end
  
  describe 'Group#index page functionality' do
    it 'Groups page is presented after logged in' do
      expect(page).to have_content("Add a new group")
    end

    it 'presents each group/categorie name' do
      # creates Groups
      (0..5).each do |indx|
        Group.create(name: "group #{indx}", user:)
      end
      visit group_index_path
      Group.all.each do |group|
        expect(page).to have_content(group.name)
      end
    end

    it 'presents each group/categorie icon' do
      # creates Groups
      (0..5).each do |indx|
        Group.create(name: "group #{indx}", user:)
      end
      visit group_index_path
      expect(page).to have_css('img', count: Group.all.count)
    end

    it 'redirect to group#new form when add a new group button is clicked' do
      click_on 'Add a new group'
      expect(page).to have_current_path(new_group_path)
    end
  end

  describe 'Group#new page form functionality' do
    before(:each) do
      visit new_group_path
    end
    it 'shows the new group form input fild' do
      expect(page).to have_field("group_name")
    end

    it 'creates a new group' do
      expect(Group.first).to be_nil

      fill_in "group_name", with: "sample name"
      fill_in "group_icon", with: "icon_link.png"
      click_on "Save"

      expect(Group.first).to be_an_instance_of(Group)
    end
  end
end
