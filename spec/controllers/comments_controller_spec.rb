require 'spec_helper'

describe CommentsController do

  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end

  context "crud for visitors" do
    let(:article) { FactoryGirl.create(:article, user: user) }
    let(:visitor) { FactoryGirl.create(:visitor) }

    it "can create a comment on an article if visiting site" do
      post :create, article_id: article.id, comment: {name: "leffe", email: "leffe@leffe.com", body:"leffe was here"}
      assigns(:comment).body.should == "leffe was here"
    end
  end
end