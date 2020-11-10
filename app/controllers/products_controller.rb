class ProductsController < ApplicationController
  authorize_resource

  def index
    @products = Product.all
  end

  def show
    @cart_item = CartItem.new
  end

  def new
    @categories = Category.all
    @product = category.products.new
    @product.product_properties.build
  end

  def create
    @category = Category.find(params[:product][:category_id])
    @product = Product.new(product_params)

    if @product.save
      redirect_to category_path(@category), notice: 'Product successfully added!'
    else
      render :new
    end
  end

  private

  def category
    @category ||= Category.find(params[:category_id])
  end

  helper_method :category

  def product
    @product ||= params[:id] ? Product.with_attached_images.find(params[:id]) : Product.new
  end

  helper_method :product

  def product_params
    params.require(:product).permit(:name,
                                    :category_id,
                                    :description,
                                    :price,
                                    images: [],
                                    product_properties_attributes: [:id, :property_id, :value, :_destroy])
  end
end