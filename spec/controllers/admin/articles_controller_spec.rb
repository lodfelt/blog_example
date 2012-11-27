require 'spec_helper'

describe Admin::ArticlesController do

  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end
  context "crud via browser" do
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

  context "crud via JSON api" do
    let(:article) { FactoryGirl.create(:article, user: user) }

    it "allows a skeleton article to be returned through the JSON api" do
      get :new, id: article.id, format: :json
      response.status.should be 200

      response_data = ActiveSupport::JSON.decode @response.body
      response_data.should be_a Hash
    end

    it "allows an article to be created through the JSON api" do
      post :create, format: :json, article: {
        title: "an article",
        body: "article body",
        user_id: user.id
      }

      response.status.should be 201
      response_data = ActiveSupport::JSON.decode @response.body
      response_data.should be_a Hash
      response_data["body"].should == 'article body'
      response_data["title"].should == 'an article'
      response_data["published"].should be_false

      response.location.should == article_url(response_data["id"])
    end

    it "allows an article to be updated through the JSON api" do
      put :update, format: :json, id: article.id, article: {
        title: "updated article",
        body: "updated body",
        published: true
      }

      response.status.should be 200
      response_data = ActiveSupport::JSON.decode @response.body
      response_data.should be_a Hash
      response_data["body"].should == 'updated body'
      response_data["title"].should == 'updated article'
      response_data["published"].should be_true

      response.location.should == article_url(response_data["id"])
    end

    it "allows an article to be deleted through the JSON api" do
      article
      expect {
        delete :destroy, format: :json, id: article.id
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

  context "tags" do
    it "seperates the tags on whitepace when creating an article with multiple tags" do
      expect {
        post :create, article: { title: "an article", body: "article body", tag_names: "tag1, tag2", user_id: user.id}
      }.to change { Tag.all.count }.from(0).to(2)
    end
  end
end
