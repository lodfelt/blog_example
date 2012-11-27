class Impression < ActiveRecord::Base
  attr_accessible :ip_address, :user_id
  belongs_to :impressionable, polymorphic: true
end
