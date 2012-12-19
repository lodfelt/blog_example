class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_ariane

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end
  def after_sign_out_path_for(resource_or_scope)
    root_url
  end

  protected

  def set_ariane
    ariane.add t(:'common.home'), root_path
  end
end
