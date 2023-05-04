require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "associations" do
    it { should belong_to(:author).class_name("User") }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(200) }
    it { should validate_numericality_of(:comments_counter).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).is_greater_than_or_equal_to(0) }
  end

  describe "callbacks" do
    describe "#update_post_counter" do
      let(:author) { create(:user) }
      let(:post) { create(:post, author: author) }
      let(:comment) { create(:comment, post: post) }

      it "updates the author's posts_counter" do
        expect {
          post.save
          author.reload
        }.to change(author, :posts_counter).from(0).to(1)
      end
    end
  end

  describe "private methods" do
    describe "#recent_comments" do
      let(:post) { create(:post) }

      it "returns up to 5 comments in reverse order of creation time" do
        comments = create_list(:comment, 10, post: post)
        recent_comments = post.send(:recent_comments)
        expect(recent_comments).to eq(comments.last(5).reverse)
      end
    end
  end
end
