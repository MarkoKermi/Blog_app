require 'rails_helper'
require 'capybara'


# RSpec.feature 'User index page' do
#   scenario 'displaying user information' do
#     # Create some sample users
#     user1 = User.create(name: 'Marko', posts_counter: 5)
#     user2 = User.create(name: 'Ivana', posts_counter: 3)

#     visit users_path

#     # Ensure the username of all users is displayed
#     expect(page).to have_content(user1.name)
#     expect(page).to have_content(user2.name)

#   #   # Ensure the profile picture is displayed for each user
#     expect(page).to have_css('.picture_user', count: 2)

#   #   # Ensure the number of posts for each user is displayed
#     expect(page).to have_content("Number of posts: #{user1.posts_counter}")
#     expect(page).to have_content("Number of posts: #{user2.posts_counter}")

    
#   #   # Ensure clicking on a user redirects to their show page
#     find('.user_view', text: user1.name) do
#       click_link(user1.name)
#     end
#     expect(current_path).to eq(user_path(user1))

#     find('.user_view', text: user2.name) do
#       click_link(user2.name)
#     end
#     expect(current_path).to eq(user_path(user2))
#   end
# end


RSpec.describe 'User index page:', type: :feature do
  before(:each) do
    @user_one = User.new(name: 'unique', photo: 'http://localhost:3000/anything.jpg', bio: 'Anything test')
    @user_one.save
    @post = Post.new(title: 'Anything', text: 'Anything test', author: @user_one)
    @post.save
  end

  scenario 'I can see the username of all other users' do
      visit users_path
      expect(page).to have_content(@user_one.name)
  end
  scenario 'I can see the profile picture for each user.s' do
    visit users_path
    expect(@user_one.photo).to match(%r{^http?://.*\.(jpe?g|gif|png)$})
  end
  scenario 'I can see the number of posts each user has written.' do
     visit users_path
     expect(page).to have_content(@user_one.posts.count)
  end
 scenario 'When I click on a user, I am redirected to that user show page' do
  visit users_path
  click_link(@user_one.name)
  expect(page).to have_current_path(user_path(@user_one.id))
 end
end