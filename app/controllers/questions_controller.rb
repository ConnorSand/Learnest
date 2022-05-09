class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_id, only: %i[show edit update]

  def index
    # @questions = policy_scope(Question).order(created_at: :desc)
    if params[:query].present?
      @question_search = policy_scope(Question).global_search(params[:query])
      @questions = @question_search
    else
      @questions = policy_scope(Question)
    end
  end

  def show
    # to facilitate responding to a question with an answer
    @answer = Answer.new
    # to display answers to the question
    @answers = Answer.where(question_id: params[:id])
  end

  def new
    @question = Question.new
    authorize @question
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.save
    authorize @question
    if @question.save
      redirect_to question_path(@question)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @question.update(question_params)
    respond_to do |format|
      format.html { redirect_to question_path(@question) }
      format.text { render partial: "questions/question_info", locals: { question: @question }, formats: [:html] }
    end
  end

  private

  def question_params
    params.require(:question).permit(:content, :is_archived)
    # params.require(:question).permit(:content, :tag_list)
  end

  def find_id
    @question = Question.find(params[:id])
    authorize @question
  end

  # def tagged
  #   if params[:tag].present?
  #     @questions = Question.tagged_with(params[:tag])
  #   else
  #     @questions = Question.all
  #   end
  # end
end
