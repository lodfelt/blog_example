class TagsController < ApplicationController
  layout 'public'
  load_and_authorize_resource :tag
  def show
    @articles = @tag.articles
  end

  protected

  def set_ariane
    super
    tag = Tag.find(params[:id])
    ariane.add tag.name, tag_path(tag)
  end
end
