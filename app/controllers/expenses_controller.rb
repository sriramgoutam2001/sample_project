require_relative '../services/invoice_validator'
class ExpensesController < ApplicationController

    def approve
      expense = Expense.find(params[:id])
      expense.update(expense_status: :approved)
      # Optionally, send an email notification to the employee here.
      redirect_to expense_path(expense), notice: 'Expense approved successfully.'
    end

    def reject
      expense = Expense.find(params[:id])
      expense.update(expense_status: :rejected)
      # Optionally, allow admins to add comments when rejecting expenses.
      # You can add a "reject_reason" attribute to the Expense model for this purpose.
      # Then, display the reason in the rejection email notification to the employee.
      redirect_to expense_path(expense), notice: 'Expense rejected successfully.'
    end

    def index
      if current_user.admin
        @expenses = Expense.all
      else 
        @expenses = current_user.expenses.all
      end
    end
  
    def show
      if current_user.admin
        @expense = Expense.find(params[:id])
      else 
        @expense = current_user.expenses.find(params[:id])
      end
    end
  
    def new
      @expense = current_user.expenses.new
    end
  
    def create
      @expense = current_user.expenses.new(expense_params)

      if InvoiceValidator.validate(@expense.invoice_number)
        puts 'Invoice validation succeeded!'
        if @expense.save
          flash[:notice] = 'Expense has been successfully added.'
          redirect_to expense_path(@expense)
        else
          puts @expense.errors.full_messages.inspect
          render :new, status: :unprocessable_entity
        end
      else 
        puts 'Invoice validation failed!'
        @expense.errors.add(:invoice_number, 'Invoice validation failed.')
        @expense.errors[:invoice_number].each do |message|
          flash.now[:alert] = message
        end
        render :new
      end
    end
  
    def edit
      @expense = current_user.expenses.find(params[:id])
    end
  
    def update
      @expense = current_user.expenses.find(params[:id])
      if @expense.update(expense_params)
        flash[:notice] = 'Expense details updated successfully.'
        redirect_to expenses_path
      else
        puts @expense.errors.full_messages.inspect
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @expense = current_user.expenses.find(params[:id])
      @expense.destroy
      flash[:notice] = 'Expense deleted successfully.'
      redirect_to expenses_path
    end
  
    private
  
    def expense_params
      params.require(:expense).permit(:amount, :date, :description, :invoice_number, :user_id, :bill)
    end
  end