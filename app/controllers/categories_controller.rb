class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    authorize! :create, Category
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to category_path(@category), notice: 'Category successfully created!'
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end