require "content_store"

module Berg
  class Page
    attr_reader :options, :content_store

    def initialize(options = {})
      @options = options
      @content_store = ContentStore.new
    end

    def view_locals
      {
        assets: assets,
        csrf_tag: csrf_tag,
        csrf_token: csrf_token,
        current_path: current_path,
        content_store: content_store,
      }
    end

    def current_path
      self[:current_path].()
    end

    def csrf_metatag
      self[:csrf_metatag].()
    end

    def csrf_tag
      self[:csrf_tag].()
    end

    def csrf_token
      self[:csrf_token].()
    end

    def assets
      self[:assets]
    end

    def flash
      self[:flash]
    end

    def flash?
      %i(notice alert).any? { |type| flash[type] }
    end

    def with_flash(flash)
      with(flash: flash)
    end

    def with(new_options)
      self.class.new(options.merge(new_options))
    end

    def [](name)
      options.fetch(name)
    end
  end
end
