require 'spec_helper'

describe Admin::ArticlesController do

  let!(:user) { FactoryGirl.create(:admin) }

  before(:each) do
    sign_in user
  end

  context "index action" do
    let!(:article) { FactoryGirl.create(:article, user: user) }
    let!(:draft) { FactoryGirl.create(:draft, user: user) }

    it "indexes only published articles and not drafts" do
      get :index
      response.status.should == 200
      assigns(:articles).should == Article.published.all(include: :user)
    end
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

      response.location.should == article_url(response_data["id"])
    end

    it "allows an article to be updated through the JSON api" do
      put :update, format: :json, id: article.id, article: {
        title: "updated article",
        body: "updated body",
      }

      response.status.should be 200
      response_data = ActiveSupport::JSON.decode @response.body
      response_data.should be_a Hash
      response_data["body"].should == 'updated body'
      response_data["title"].should == 'updated article'

      response.location.should == article_url(response_data["id"])
    end

    it "allows an article to be deleted through the JSON api" do
      article
      expect {
        delete :destroy, format: :json, id: article.id
      }.to change { Article.all.count }.from(1).to(0)
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
