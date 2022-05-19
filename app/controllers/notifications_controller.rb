class NotificationsController < ApplicationController

  def mark_as_read
    @notification = Notification.find(params[:id])
    authorize @notification
    @notification.mark_as_read!

    redirect_to notifications_path
  end
end
