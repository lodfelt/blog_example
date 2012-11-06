class TagsController < ApplicationController

  load_and_authorize_resource :tag
  def show
    @articles = @tag.articles
  end
end
