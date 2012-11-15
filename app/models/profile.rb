class Profile < ActiveRecord::Base
  attr_accessible :about, :links, :user_id
  belongs_to :user
end
