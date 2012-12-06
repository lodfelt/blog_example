require 'spec_helper'

describe UserMailer do
  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")
  let(:user) { FactoryGirl.create(:user) }
  let!(:article) { FactoryGirl.create(:article, user_id: user.id) }

  it "delivers comment_on_article mail to article author" do
    email = UserMailer.comment_on_article(article).deliver
    ActionMailer::Base.deliveries.should_not be_empty

    article.user.email.should == email.to[0]
    email.subject.should == 'Your article was commented on'

  end
end