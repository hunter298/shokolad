class CategoriesController < ApplicationController
  authorize_resource

  def index
    @categories = Category.all
  end

  def new
    category.properties.build
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category successfully created!'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
    end
  end

  private

  def category
    @category ||= params[:id] ? Category.with_attached_image.find(params[:id]) : Category.new
  end

  helper_method :category

  def category_params
    params.require(:category).permit(:name, :image, properties_attributes: [:id, :name, :_destroy])
  end
end
