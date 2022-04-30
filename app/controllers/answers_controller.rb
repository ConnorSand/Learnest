class AnswersController < ApplicationController
  before_action :find_answer, only: [:edit, :update]
  before_action :find_question, only: [:edit, :update, :new, :create]

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @answer.user = current_user
    @answer.save

    if @answer.save
      redirect_to question_path(@question)
    else
      render 'questions/show'
    end
  end

  def edit
  end

  def update
    @answer.question = @question
    @question.update(question_params)

    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render 'questions/show'
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])

  end

  def find_answer
    @answer = Answer.find(params[:id])
    authorize @answer
  end

  def answer_params
    params.require(:answer).permit(:content, :selected_answer, :is_archived)
  end
end
