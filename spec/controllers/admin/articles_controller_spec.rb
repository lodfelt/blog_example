require 'spec_helper'

describe Admin::ArticlesController do

  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")
  user = User.create(email: "test_user@example.com", password: "passw0rd")

  before(:each) do
    sign_in user
  end
  context "crud" do
    it "is possible to create an article through the browser" do
      post :create, article: { title: "an article", body: "article body", user_id: user.id}

      assigns(:article).title.should == "an article"
    end

    it "is possible to update an article through the browser" do
      put :update, article: { title: "updated", body: ""}
    end
  end

  context "published" do

    it "cant publish or unpublish articles via published action if not admin" do
      article = Article.create(title: "not published", body: "this is unpublished", user_id: user.id, published: false)
      post :published, id: article.id
      article.reload
      article.published.should == false
    end

    it "can publish if admin user" do
      admin_user = User.create(email: "admin_user@example.com", password: "adminpassw0rd")
      article = Article.create(title: "another article", body: "this is unpublished", user_id: admin_user.id, published: false)
      sign_in admin_user
      admin_user.role_ids = [1]
      post :published, id: article.id
      article.reload
      article.published.should == true
    end
  end
end
