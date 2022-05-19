class NotificationsController < ApplicationController

  def mark_as_read
    @notification = Notification.find(params[:id])
    authorize @notification
    @notification.mark_as_read!

    redirect_to notifications_path
  end

  def mark_all_as_read
    @notifications = current_user.notifications
    authorize @notifications
    @notifications.mark_as_read!
  end
end
