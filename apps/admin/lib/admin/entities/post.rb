require "types"
require "admin/entities/category"
require "admin/entities/asset"

module Admin
  module Entities
    class Post < Dry::Types::Value
      attribute :id, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribute :teaser, Types::Strict::String
      attribute :body, Types::Strict::String
      attribute :cover_image, Types::Coercible::Hash.optional
      attribute :slug, Types::Strict::String
      attribute :status, Types::PostStatus
      attribute :person_id, Types::Strict::Int
      attribute :published_at, Types::Strict::Time.optional
      attribute :color, Types::PostHighlightColor

      def deleted?
        status == "deleted"
      end

      def published?
        status == "published"
      end
    end

    class PostWithCategoriesAssets < Post
      attribute :post_categories, Types::Strict::Array.member(Admin::Entities::Category)
      attribute :assets, Types::Strict::Array.member(Admin::Entities::Asset).optional
    end
  end
end
