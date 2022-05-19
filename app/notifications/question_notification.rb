# To deliver this notification:
#
# QuestionNotification.with(post: @post).deliver_later(current_user)


class QuestionNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # def to_database
  #   {
  #     type: self.class.name,
  #     params:params
  #   }
  # end

  # param :question

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  #
  def url
    question_path(params[:question])
  end
end
