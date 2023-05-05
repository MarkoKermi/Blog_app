require_relative './rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.create(
      name: 'Loren',
      photo: 'https://this-person-does-not-exist.com/en/download-page?image=genef4e9868ae582ca3061881b69d8fbeb1',
      posts_counter: 0,
      bio: 'I am Loren, and I love sport.'
    )
  end

  subject do
    Post.new(
      title: 'My first post',
      author: user,
      text: 'The motivation to become developer is very big.',
      comments_counter: 0,
      likes_counter: 0
    )
  end

  before { subject.save }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with negative comments_counter' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'is not valid with negative likes_counter' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end
end
