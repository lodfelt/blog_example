require 'spec_helper'

describe Article do
  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")

  context "published" do
    user = User.create(email: "test_user@example.com", password: "passw0rd")
    unpublished = Article.create(title: "unpublished", body: "this is unpublished", user_id: user.id, published: false)
    published = Article.create(title: "published", body: "this is published", user_id: user.id, published: true)

    it "has scope published which returns all published articles" do
      Article.published.count.should == 1
    end
  end
end