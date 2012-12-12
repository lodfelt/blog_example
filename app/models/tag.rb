class Tag < ActiveRecord::Base
  attr_accessible :name

  default_scope order: 'name ASC'

  has_many :taggings, dependent: :destroy
  has_many :articles, through: :taggings

end
