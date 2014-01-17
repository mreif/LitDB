class ApplicationController < ActionController::Base
  
 # rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
 #   render :text => exception, :status => 500
#  end
  
 # rescue_from ActionController::RoutingError, :with => :render_404
 # rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  # Just renders a 404 page if a exception occurs
  
  private
  def render_404(exception = nil)
    
     if exception
       logger.info "Rendering 404: #{exception.message}"
     end
    
     render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
  def after_sign_out_path_for(resource_or_scope)
    publications_path
  end

  def after_sign_in_path_for(resource_or_scope)
    publications_path
  end


  protect_from_forgery
end
