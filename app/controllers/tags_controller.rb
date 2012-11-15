class TagsController < ApplicationController
  layout 'public'
  load_and_authorize_resource :tag
  def show
    @articles = @tag.articles
  end
end
