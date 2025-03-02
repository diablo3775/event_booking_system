module Api
    module V1
      class CustomersController < ApplicationController
        def create
          if Customer.exists?(email: customer_params[:email])
            render json: { error: 'Customer with this email already exists' }, status: :unprocessable_entity
          else
            customer = Customer.new(customer_params)
            if customer.save
              render json: { message: 'Customer created successfully', customer: customer }, status: :created
            else
              render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
            end
          end
        end
  
        private
  
        def customer_params
          params.require(:customer).permit(:name, :email, :password)
        end
      end
    end
  end
  