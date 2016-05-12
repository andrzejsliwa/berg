require "main/import"
require "main/view"
require "main/decorators/public_post"

module Main
  module Views
    module Posts
      class Index < Main::View
        include Main::Import("main.persistence.repositories.posts")

        configure do |config|
          config.template = "posts/index"
        end

        def locals(options = {})
          options = {per_page: 20, page: 1}.merge(options)
          all_posts = posts.listing(page: options[:page], per_page: options[:per_page])

          public_posts = all_posts.to_a.map { |a|
            Decorators::PublicPost.new(a)
          }

          super.merge(
            posts: public_posts,
            paginator: all_posts.pager
          )
        end
      end
    end
  end
end
