require 'spec_helper'

describe User do
  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")
  let(:user) { FactoryGirl.create(:user) }

  context "roles" do
    it "defaults to a member when a user is created in the system" do
      user.role?(:member).should be_true
      user.role?(:admin).should be_false
    end
  end

  context "user profile" do
    it "is associated with a profile after a user is created" do
      user.profile.should_not be_nil
    end
  end

  it "can fetch the whole name for a user based on first_name and last_name" do
    user.first_name = "Leif"
    user.last_name = "Leifursson"
    user.save

    user.name.should == "Leif Leifursson"
  end
end