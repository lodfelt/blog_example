require 'spec_helper'

describe Article do
  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")

  context "published" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:unpublished) { FactoryGirl.create(:article, user_id: user.id) }
    let!(:published) { FactoryGirl.create(:published, user_id: user.id) }

    it "has scope published which returns all published articles" do
      Article.published.count.should == 1
    end
  end
end