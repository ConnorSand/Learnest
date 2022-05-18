class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def notifications
    @notifications = Notification.where(recipient: current_user)
  end
end
