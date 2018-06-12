class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:home]
  before_action :set_months

  def home
    if user_signed_in?
      @month = "All"
      AaqStarRatingAdapter.get_ratings
      OneOnOneRatingAdapter.get_ratings
      StudyGroupStarRatingAdapter.get_ratings
    end
    render '/home'
  end

  def search
    @month = params.to_unsafe_h[:month]
    render '/home'
  end

  private
  def authorize_user!
     redirect_to root_path if !current_user || !current_user.is_admin?
  end

  def set_months
    @months = [
      "All",
      "January", "February", "March", "April",
      "May", "June", "July", "August",
      "September", "October", "November", "December"
    ]
  end
end
