class Admin::TagsController < ApplicationController

  load_and_authorize_resource :tag

  def index
    @tags = Tag.all
  end

  def destroy
    authorize! :delete, @tag
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
