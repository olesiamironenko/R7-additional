class OrdersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
    before_action :set_order, only: %i[ show edit update destroy ]
    
    # GET /orders or /orders.json
    def index
        @orders = Order.all
    end
    
    # GET /orders/1 or /orders/1.json
    def show
    end
    
    # GET /orders/new
    def new
        @order = Order.new(customer_id: params[:customer_id])
    end
    
    # GET /orders/1/edit
    def edit
    end
    
    # POST /orders or /orders.json
    def create
        @order = Order.new(order_params)
        if @order.save
            flash[:notice] = "The order record was created successfully."
            redirect_to @order
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    # PATCH/PUT /orders/1 or /orders/1.json
    def update
        if @order.update(order_params)
            flash[:notice] = "The order record was updated successfully."
            redirect_to @order
        else
            flash[:alert] = "The order record cannot be updated."
            render :edit, status: :unprocessable_entity
        end
    end
    
    # DELETE /orders/1 or /orders/1.json
    def destroy
        @order.destroy
            respond_to do |format|
            format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:customer_id, :full_name, :product_name, :product_count)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flas[:error] = e.to_s
      redirect_to orders_path
    end

    def set_customer
        @customer = Customer.find(params[:id])
      end

end
