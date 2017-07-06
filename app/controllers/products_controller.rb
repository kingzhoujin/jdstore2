class ProductsController < ApplicationController
  before_action :authenticate_user!

    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to products_path
      else
        render :new
      end
    end

    def edit
      @product = Product.find(params[:id])
    end

    def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to admin_products_path
      else
        render :edit
      end
    end

    def show
      @product = Product.find(params[:id])
    end

    def destroy
      @product = Product.find(params[:id])
      @product.delete
      redirect_to admin_products_path
    end

    def add_to_cart
      @product = Product.find(params[:id])
      if !current_cart.product.include?(@product)
         current_cart.add_product_to_cart(@product)
         flash[:notice] = "你已经成功将#{@product.title}加入购物车"
      else
         flash[:warning] = "你的购物车内已有此物品"
       end
         redirect_to :back
     end

    private

    def product_params
      params.require(:product).permit(:title, :description, :quantity, :price, :image)
    end



end
