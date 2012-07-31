class InvestorsController < ApplicationController
  around_filter :record_user_action
  before_filter :login_required

  def index
    authorize! :see_investors, User
  end

  # Show a new startup to an investor
  def show_startup 
    authorize! :investor_connect_with_startups, current_user
    @startup = Startup.order('RAND()').first
    @rating = Rating.new(:startup_id => @startup.id)
    @checkin_history = Checkin.history_for_startup(@startup)

    # Temporary hack until we build suggested startups
    Relationship.suggest_connection(current_user, @startup, :startup_investor)

  end
end
