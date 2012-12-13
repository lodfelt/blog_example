class Article < ActiveRecord::Base
  attr_accessible :body, :title, :tag_names, :user_id, :published_on, :markdown, :use_editor, :draft

  validates_presence_of :title

  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :images, class_name: "ArticleImage", dependent: :destroy
  has_many :impressions, as: :impressionable
  belongs_to :user
  scope :published, -> { where(draft: false) }
  scope :drafts, -> { where(draft: true) }

  validates_numericality_of :user_id
  default_scope order: 'published_on DESC'

  attr_writer :tag_names
  after_save :assign_tags

  def tag_names
    @tag_names || tags.map(&:name).join(", ")
  end

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
      ActionController::Base.new.expire_fragment('all_articles')
    else
      published
    end
  end

  def impression_count
    impressions.size
  end

  def unique_impression_count
    impressions.group(:ip_address).size #UNTESTED: might not be correct syntax
  end

  private

  def assign_tags
    if @tag_names
      ActionController::Base.new.expire_fragment('shared_tags')
      ActionController::Base.new.expire_fragment('all_articles')
      self.tags = @tag_names.split(",").map do |name|
        Tag.find_or_create_by_name(name.strip)
      end
    end
  end
end
