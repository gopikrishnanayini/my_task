class CustomersController < ApplicationController
	before_action :authenticate_user!
	before_action :find_customer, :only => [:show, :edit , :update, :destroy]

  def index
  	@customers = Customer.all
  end

  def new
    @customer = Customer.new
  end
 
  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'customer was successfully created.' }
        format.json { render json: show, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'customer was successfully updated.' }
        format.json { render json: show, status: :ok, location: @customer }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@customer.destroy
  	redirect_to customers_path
  end

  private
  def find_customer
  	@customer = Customer.find(params[:id])
  end

  def customer_params
  	params.require(:customer).permit!
  end
end
