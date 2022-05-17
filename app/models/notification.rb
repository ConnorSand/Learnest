class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  # after_create_commit :notifiy_recipient

  # private

  # def notifiy_recipient
  #   NewMessageNotificatin.with(message: self).deliver(recipient)
  # end
end
