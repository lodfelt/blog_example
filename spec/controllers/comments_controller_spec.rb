require 'spec_helper'

describe CommentsController do

  let!(:author) { FactoryGirl.create(:author) }

  context "crud for visitors" do
    let(:article) { FactoryGirl.create(:article, user: author) }
    let(:visitor) { FactoryGirl.create(:visitor) }
    let!(:comment) { FactoryGirl.create(:comment, article_id: article.id) }

    it "can create a comment on an article if visiting site" do
      sign_in visitor
      post :create, article_id: article.id, comment: {name: "leffe", email: "leffe@leffe.com", body:"leffe was here"}
      assigns(:comment).body.should == "leffe was here"
    end

    it "can delete a comment on an article if author" do
      sign_in author
      expect {
        delete :destroy, article_id: article.id, id: comment.id
      }.to change { article.comments.count }.from(1).to(0)
    end
  end
end