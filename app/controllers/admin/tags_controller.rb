class Admin::TagsController < ApplicationController

  load_and_authorize_resource :tag

  def destroy
    authorize! :delete, @tag
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.json { head :no_content }
    end
  end
end
