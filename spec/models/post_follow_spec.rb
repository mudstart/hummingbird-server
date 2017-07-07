# rubocop:disable Metrics/LineLength
# == Schema Information
#
# Table name: post_follows
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer          indexed
#  user_id    :integer          indexed
#
# Indexes
#
#  index_post_follows_on_post_id  (post_id)
#  index_post_follows_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_8cdaf33e9c  (user_id => users.id)
#  fk_rails_afb3620fdd  (post_id => posts.id)
#
# rubocop:enable Metrics/LineLength

require 'rails_helper'

RSpec.describe PostFollow, type: :model do
  subject { build(:post_follow) }

  it { should belong_to(:post) }
  it { should belong_to(:user) }
  it { should validate_uniqueness_of(:post).scoped_to(:user_id) }

  context 'which is on AMA that is closed' do
    let(:ama) { create(:ama, start_date: 6.hours.ago) }
    let(:post) { build(:post, ama: ama) }
    let(:post_follow) { build(:post_follow, post: post) }

    subject { post_follow }

    it 'should not be valid' do
      should_not be_valid
    end
  end
end
