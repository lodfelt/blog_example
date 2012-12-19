require 'spec_helper'
require "cancan/matchers"

describe Ability do

  let(:ability) { Ability.new(user) }
  let(:article) { FactoryGirl.create :article }

  context "permissions for visitors without role" do
    let(:ability_visitors) { Ability.new(nil) }

    it "can read several items and create comments" do
      ability_visitors.should be_able_to(:read, Article)
      ability_visitors.should be_able_to(:read, Comment)
      ability_visitors.should be_able_to(:read, Tag)
      ability_visitors.should be_able_to(:read, ArticleImage)
      ability_visitors.should be_able_to(:read, User)
      ability_visitors.should be_able_to(:create, Comment)
    end

    it "cannot do more administrative things for articles" do
      ability_visitors.should_not be_able_to([:create, :edit, :update, :destroy], [Article, Comment])
      ability_visitors.should_not be_able_to(:access, :admin)
      ability_visitors.should_not be_able_to(:update, User)
    end
  end

  context "permissons for users with member role" do
    let(:user) { FactoryGirl.create(:author) }

    it "can crud articles but not access admin" do
      ability.should be_able_to(:read, :all)
      ability.should be_able_to(:update, User)
      ability.should be_able_to(:create, Article)
      ability.should be_able_to(:update, Article)
      ability.should be_able_to(:destroy, Article)
      ability.should be_able_to(:destroy, Tag)

      ability.should_not be_able_to(:access, :admin)
    end
  end

  context "permissions for admin users" do
    let(:user) { FactoryGirl.create(:admin) }
    it "should manage all" do
      ability.should be_able_to(:manage, :all)
    end
  end
end
