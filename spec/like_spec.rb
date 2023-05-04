RSpec.describe Like, type: :model do
  describe "associations" do
    it { should belong_to(:author).class_name("User") }
    it { should belong_to(:post) }
  end

  describe "callbacks" do
    describe "#update_likes_counter" do
      let(:post) { create(:post) }
      let(:like) { create(:like, post: post) }

      it "updates the post's likes_counter" do
        expect {
          like.save
          post.reload
        }.to change(post, :likes_counter).from(0).to(1)
      end
    end
  end
end
