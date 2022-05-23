class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_id, only: %i[show edit update upvote downvote]

  def upvote
    authorize @question
    @question.upvote_by current_user
    redirect_back fallback_location: root_path
  end

  def downvote
    authorize @question
    @question.downvote_by current_user
    redirect_back fallback_location: root_path
  end

  def index
    if params[:query].present?

      query = params[:query]
      @question_search = policy_scope(Question).global_search(params[:query])
      @questions = @question_search.sort_by(&:weighted_score).reverse.paginate(page: params[:page], per_page: 10)
      # raise
      if params[:order] == 'datenew'
        @question_search = policy_scope(Question).global_search(query)
        return @questions = @question_search.sort_by(&:created_at).reverse.paginate(page: params[:page], per_page: 10)
      elsif params[:order] == 'dateold'
        @question_search = policy_scope(Question).global_search(query)
        return @questions = @question_search.sort_by(&:created_at).paginate(page: params[:page], per_page: 10)
      else
        @question_search = policy_scope(Question).global_search(query)
        return @questions = @question_search.sort_by(&:weighted_score).reverse.paginate(page: params[:page], per_page: 10)
      end

    else
      @questions = policy_scope(Question)
      if params[:order] == 'datenew'
        return  @questions = @questions.sort_by(&:created_at).reverse.paginate(page: params[:page], per_page: 10)
      elsif params[:order] == 'dateold'
        return @questions = @questions.sort_by(&:created_at).paginate(page: params[:page], per_page: 10)
      else
        return @questions = @questions.sort_by(&:weighted_score).reverse.paginate(page: params[:page], per_page: 10)
      end
    end
  end

  def show
    # to facilitate responding to a question with an answer
    @answer = Answer.new
    # to display answers to the question
    @answers = Answer.where(question_id: params[:id])

    if params[:order] == 'datenew'
      @answers = @answers.sort_by(&:created_at).reverse.paginate(page: params[:page], per_page: 10)
      return @answers
    elsif  params[:order] == 'dateold'
      @answers = @answers.sort_by(&:created_at).paginate(page: params[:page], per_page: 10)
      return @answers
    else
      @answers = @answers.sort_by(&:weighted_score).reverse.paginate(page: params[:page], per_page: 10)
    end
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
    params.require(:question).permit(:title, :content, :is_archived)
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
