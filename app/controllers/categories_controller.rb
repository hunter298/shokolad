class CategoriesController < ApplicationController
  def index
    authorize! :read, Category
    @categories = Category.all
  end

  def new
    authorize! :create, Category
    @category = Category.new
    @category.properties.build
  end

  def create
    authorize! :create, Category
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category successfully created!'
    else
      render :new
    end
  end

  def show
    authorize! :read, Category
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name, :image, properties_attributes: [:id, :name, :_destroy])
  end
end
