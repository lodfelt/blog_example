require 'carrierwave/test/matchers'
require 'spec_helper'

describe ArticleUploader do
  include CarrierWave::Test::Matchers

  admin_role = Role.create(name: "admin")
  member_role = Role.create(name: "member")
  let(:user) { FactoryGirl.create(:user) }
  let!(:article) { FactoryGirl.create(:article, user_id: user.id) }

  before do
    @uploader = ArticleUploader.new(article, :image)
    @uploader.store!(File.open('spec/support/data/rails.png'))
  end

  after do
    @uploader.remove!
  end

  context 'versions' do
    it "large version should ave correct dimensions" do
      @uploader.large.should have_dimensions(640, 360)
    end
    it "inline version should ave correct dimensions" do
      @uploader.inline.should have_dimensions(410, 270)
    end
    it "thumb version should ave correct dimensions" do
      @uploader.thumb.should have_dimensions(270, 180)
    end
    it "small version should ave correct dimensions" do
      @uploader.small.should have_dimensions(68, 45)
    end
  end
end