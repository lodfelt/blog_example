require 'spec_helper'

describe ArticlesController do

  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")
  user = User.create(email: "test_user@example.com", password: "passw0rd")

  before(:each) do
    sign_in user
  end

end
