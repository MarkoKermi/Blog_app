require './rails_helper.rb'

RSpec.describe Comment, type: :model do
  describe "associations" do
    it { should belong_to(:author).class_name("User") }
    it { should belong_to(:post) }
  end

  describe "callbacks" do
    describe "#update_comments_counter" do
      let(:author) { create(:user) }
      let(:post) { create(:post, author: author) }
      let(:comment) { create(:comment, post: post) }

      it "updates the post's comments_counter" do
        expect {
          comment.save
          post.reload
        }.to change(post, :comments_counter).from(0).to(1)
      end
    end
  end
end
