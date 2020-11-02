class ProductsController < ApplicationController
  def show
    authorize! :read, @product
    @product = Product.find(params[:id])
  end

  def new
    authorize! :create, Product
    @category = Category.find(params[:category_id])
    @categories = Category.all
    @product = @category.products.new
    @product.product_properties.build
  end

  def create
    authorize! :create, Product
    # render plain: params[:product][:category_id]
    @category = Category.find(params[:product][:category_id])
    @product = Product.new(product_params)

    if @product.save
      redirect_to category_path(@category), notice: 'Product successfully added!'
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name,
                                    :category_id,
                                    images: [],
                                    product_properties_attributes: [:id, :property_id, :value, :_destroy])
  end
end