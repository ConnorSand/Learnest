class AnswersController < ApplicationController
  before_action :find_question, only: [ :edit, :update, :create, :upvote, :downvote, :filter_by_date_newest, :filter_by_date_oldest, :filter_by_votes ]
  before_action :find_answer, only: [ :edit, :update, :upvote, :downvote]

  def new
    @answer = Answer.new
  end

  def create

    @answer = Answer.new(answer_params)
    @answer.question = @question
    @answer.user = current_user
    @answer.save
    authorize @answer
    if @answer.save
      QuestionNotification.with(answer: @answer).deliver(@question.user)
      redirect_to question_path(@question)
    else
      render 'questions/show'
    end
  end

  def edit
    @question = Question.find(params[:question_id])
    authorize @answer
  end

  def update
    authorize @answer
    @question = @answer.question
    @answer.update(answer_params)

    respond_to do |format|
      format.html { redirect_to question_path(@question) }
      format.text { render partial: "answers/answer_info", locals: { question: @question, answer: @answer }, formats: [:html] }
    end
  end

  def upvote
    authorize @answer
    @answer.upvote_by current_user
    redirect_back fallback_location: root_path
  end

  def downvote
    authorize @answer
    @answer.downvote_by current_user
    redirect_back fallback_location: root_path
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:content, :selected_answer, :is_archived, :photo)
  end
end
