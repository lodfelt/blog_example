class Article < ActiveRecord::Base
  attr_accessible :body, :title, :tag_names, :user_id, :published, :image

  validates_presence_of :title

  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  validates_numericality_of :user_id
  belongs_to :user
  default_scope order: 'updated_at DESC'
  scope :published, -> { where(published: true) }
  mount_uploader :image, ArticleUploader

  attr_writer :tag_names
  after_save :assign_tags

  def tag_names
    @tag_names || tags.map(&:name).join(' ')
  end

  def toggle_published
    self.published = !(self.published)
    self.save
  end

  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(" ").map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end

end
