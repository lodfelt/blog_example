require 'spec_helper'

describe Admin::ArticlesController do

  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end
  context "crud" do
    let(:article) { FactoryGirl.create(:article, user: user) }
    it "is possible to create an article through the browser" do
      post :create, article: { title: "an article", body: "article body", user_id: user.id}
      assigns(:article).title.should == "an article"
    end

    it "is possible to update an article through the browser" do
      put :update, id: article.id, article: { title: "updated", body: ""}
      article.reload
      article.title.should == "updated"
    end

    it "is possible to delete an article through the browser" do
      article
      expect {
        delete :destroy, id: article.id
      }.to change { Article.all.count }.from(1).to(0)
    end
  end

  context "published" do
    let(:admin_user) { FactoryGirl.create(:admin) }
    let(:article) { FactoryGirl.create(:article, user: user) }
    it "cant publish article via published action if not admin" do
      post :published, id: article.id
      article.reload
      article.published.should == false
    end

    it "can publish if admin user" do
      sign_in admin_user
      post :published, id: article.id
      article.reload
      article.published.should == true

      post :published, id: article.id
      article.reload
      article.published.should == false
    end
  end
end
