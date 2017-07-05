class PostResource < BaseResource
  caching

  attributes :content, :content_formatted, :comments_count, :post_likes_count,
    :spoiler, :nsfw, :blocked, :deleted_at, :top_level_comments_count,
    :edited_at, :ama_id

  has_one :user
  has_one :target_user
  has_one :target_group
  has_one :media, polymorphic: true
  has_one :spoiled_unit, polymorphic: true
  has_one :ama
  has_many :post_likes
  has_many :comments

  filters :ama_id
end
