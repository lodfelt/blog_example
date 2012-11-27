class ArticlesController < ApplicationController
  load_and_authorize_resource :article, except: [:index, :create, :new]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :log_impression, only: [:show]
  layout "public"

  def index
    @articles = Article.search(params[:search]).paginate(per_page: 3, page: params[:page])
    @articles_by_date = @articles.group_by(&:published_on)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html {
        if request.xhr?
          render partial: "articles/articles", locals: {articles: @articles}
        end
        # else render index.html as usual
      }
      format.json { render json: @articles }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  def log_impression
    @article.impressions.create(ip_address: request.remote_ip, user_id:current_user.id)
  end
end
