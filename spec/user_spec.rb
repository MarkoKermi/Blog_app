require './rails_helper.rb'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:comments).with_foreign_key(:author_id) }
    it { should have_many(:posts).with_foreign_key(:author_id) }
    it { should have_many(:likes).with_foreign_key(:author_id) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).is_greater_than_or_equal_to(0) }
  end

  describe "#recent_posts" do
    let(:user) { create(:user) }
    let!(:recent_posts) { create_list(:post, 5, author: user, created_at: Time.current) }
    let!(:old_post) { create(:post, author: user, created_at: 1.week.ago) }

    it "returns the 3 most recent posts" do
      expect(user.recent_posts).to eq(recent_posts[0..2])
    end
  end
end
