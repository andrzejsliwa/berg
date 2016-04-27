require_relative "../core/boot"

def core
  Berg::Container
end

def main
  Main::Container
end

def admin
  Admin::Container
end

def create_user(attrs)
  if !admin["admin.persistence.repositories.users"].by_email(attrs[:email])
    admin["admin.users.operations.create"].call(attrs).value
  end
end

def create_post(attrs)
  if !admin["admin.persistence.repositories.posts"].by_slug(attrs[:slug])
    admin["admin.posts.operations.create"].call(attrs).value
  end
end

# Default password is changeme
create_user(
  email: "hello@icelab.com.au",
  name: "Icelab Admin",
  active: true
)

create_post(
  title: "This is a test post",
  content: "Some sample content for this test post",
  slug: "this-is-a-test-post"
)
