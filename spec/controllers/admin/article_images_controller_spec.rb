require 'spec_helper'

describe Admin::ArticleImagesController do

  let!(:user) { FactoryGirl.create(:admin) }
  let!(:article) { FactoryGirl.create(:article, user: user) }

  before(:each) do
    sign_in user
  end

  it "can create article images" do
    file = File.open('spec/support/data/rails.png')
    expect {
      post :create, article_id: article.id, article_image: { image: file }
    }.to change {ArticleImage.all.count}.from(0).to(1)
  end
end
