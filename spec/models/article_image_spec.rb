require 'spec_helper'

describe ArticleImage do
  let(:user) { FactoryGirl.create(:user) }

  context "update_main_article" do
    let!(:article) { FactoryGirl.create(:article, user_id: user.id) }
    let!(:main_image) { FactoryGirl.create(:article_image, article_id: article.id, article_main: true) }
    let!(:image2) { FactoryGirl.create(:article_image, article_id: article.id) }

    it "when choosing a new article main image there are no other main images" do
      image2.article_main = true
      image2.save

      image2.article_main.should == true

      main_image.reload
      main_image.article_main.should == false
    end
  end
end