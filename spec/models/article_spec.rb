require 'spec_helper'

describe Article do
  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")
  let(:user) { FactoryGirl.create(:user) }

  context "tag_names" do
    let!(:article) { FactoryGirl.create(:article, user_id: user.id) }
    it "takes a whitespace delimited string, splits into array and creates individual tags" do
      article.tag_names = "tag1, tag2, tag3"
      article.save
      article.tags.first.name.should == "tag1"
      article.tags.last.name.should == "tag3"
    end
  end

  context "searching" do
    let!(:article) { FactoryGirl.create(:article, user_id: user.id, title: "My diary") }
    let!(:article2) { FactoryGirl.create(:article, user_id: user.id, title: "My blog") }

    it "returns published articles with titles containing keyword" do
      Article.search("diary").size.should == 1
      Article.search('My').size.should == 2
    end
  end
end