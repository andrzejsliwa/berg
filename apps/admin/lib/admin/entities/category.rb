require "types"

module Admin
  module Entities
    class Category < Dry::Types::Struct
      attribute :id, Types::Strict::Int
      attribute :name, Types::Strict::String
      attribute :slug, Types::Strict::String
    end
  end
end
