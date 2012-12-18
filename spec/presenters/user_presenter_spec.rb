require 'spec_helper'

describe UserPresenter do
  include ActionView::TestCase::Behavior

  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")
  user = User.create(first_name: "Test", last_name: "Testsson", password: "passw0rd", email: "#{rand(1...100)}@example.com")

  it "returns correct information about presented user" do
  	presenter = UserPresenter.new(user, view)
  	user.profile.about = "about"
  	user.profile.links = "www.example.com"
  	user.profile.save
  	user.save

  	presenter.name.should == user.name
  	presenter.email.should == user.email
  	presenter.about.should == user.profile.about
  end
end