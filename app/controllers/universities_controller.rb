class UniversitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_id, only: %i[show edit update]

  def index
    @university = policy_scope(University).order(created_at: :desc)
  end

  def show
    @universities = University.all
  end

  def new
    @university = University.new
    authorize @university
    end

  def create
    @university = University.new(university_params)
       # @university.user 
    authorize @university
    if @university.save
      redirect_to university_path(@university)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @university.update(university_params)
      redirect_to university_path(@university)
    else
      render 'edit'
    end
  end

  private

  def university_params
    params.require(:university).permit(:name, :location, :country)
  end

  def find_id
    @university = University.find(params[:id])
    authorize @university
  end
end

