require 'rails_helper'

RSpec.describe 'User show page:', type: :feature do
  before(:each) do
    @user1 = User.new(name: 'unique_show', photo: 'http://localhost:3000/anything.jpg', bio: 'Anything test')
    @user1.save
    @post_one = Post.new(title: 'post one', text: 'post one text', author: @user1)
    @post_two = Post.new(title: 'post two', text: 'post two text', author: @user1)
    @post_three = Post.new(title: 'post three', text: 'post three text', author: @user1)
    @post_four = Post.new(title: 'post four', text: 'post four text', author: @user1)
    @post_one.save
    @post_two.save
    @post_three.save
    @post_four.save
  end
  scenario 'I can see the user profile picture' do
    visit user_path(@user1.id)
    expect(@user1.photo).to match(%r{^http?://.*\.(jpe?g|gif|png)$})
  end
  scenario 'I can see the users username.' do
    visit user_path(@user1.id)
    expect(page).to have_content(@user1.name)
  end
  scenario 'I can see the number of posts the user has written.' do
    visit user_path(@user1.id)
    expect(page).to have_content(@user1.posts.count)
  end
  scenario 'I can see the users bio' do
    visit user_path(@user1.id)
    expect(page).to have_content(@user1.bio)
  end
  scenario 'I can see the users first 3 posts' do
    visit user_path(@user1.id)
    expect(page).to have_content(@user1.most_three_recent_post.first.title)
    expect(page).to have_content(@user1.most_three_recent_post.second.title)
    expect(page).to have_content(@user1.most_three_recent_post.third.title)
  end
  scenario 'I can see a button that lets me view all of a users posts' do
    visit user_path(@user1.id)
    expect(page).to have_button('See all posts')
  end
  scenario  'When I click a users post, it redirects me to that posts show page' do
   visit user_path(@user1.id)
   click_link("Post ##{@user1.most_three_recent_post.first.id}")
   expect(page).to have_current_path(user_post_path(@user1.id,@user1.most_three_recent_post.first.id))
  end
  scenario 'When I click the see all posts button, it redirects me to the users posts index page' do
    visit user_path(@user1.id)
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(@user1.id))
  end
end
