class SitemapController < ApplicationController
  layout nil

  def index
    @articles = Article.all
    @users = User.all
    @tags = Tag.all
    headers["Content-Type"] = "text/xml"
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end
end