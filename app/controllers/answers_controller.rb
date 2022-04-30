class AnswersController < ApplicationController
  before_action :find_question, only: [ :edit, :update, :create ]
  before_action :find_answer, only: [ :edit, :update, :create ]

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
    @question = Question.find(params[:question_id])
    authorize @answer
  end

  def update
    authorize @answer
    @question = @answer.question
    @answer.update(answer_params)

    if @answer.update(answer_params)
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
  end

  def answer_params
    params.require(:answer).permit(:content, :selected_answer, :is_archived)
  end
end
