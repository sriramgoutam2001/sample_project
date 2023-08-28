class ExpenseReportsController < ApplicationController

  # GET /expense_reports or /expense_reports.json
  def index
    if current_user.admin
      @expense_reports = ExpenseReport.all
      if params[:name].present?
        @expense_reports = @expense_reports.joins(expenses: :user).where(users: { name: params[:name] }).distinct
      end
    else
      @expense_reports = current_user.expense_reports
    end
  end

  # GET /expense_reports/1 or /expense_reports/1.json
  def show
    @expense_report = ExpenseReport.find(params[:id])
  end

  # GET /expense_reports/new
  def new
    @user_expenses = current_user.expenses
    @unused_expenses = current_user.expenses.where(expense_report_id: nil)
    @expense_report = current_user.expense_reports.new
  end

  # GET /expense_reports/1/edit
  def edit
    @user_expenses = current_user.expenses
    @unused_expenses = current_user.expenses.where('expense_report_id IS NULL OR expense_report_id = ?', params[:id])
    @expense_report = current_user.expense_reports.find(params[:id])
  end

  # POST /expense_reports or /expense_reports.json
  def create
    @expense_report = current_user.expense_reports.build(expense_report_params)

    if save_and_update_total_amount(@expense_report)
      redirect_to expense_report_path(@expense_report), notice: 'Expense report created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
    
  end

  # PATCH/PUT /expense_reports/1 or /expense_reports/1.json
  def update
    @expense_report = current_user.expense_reports.find(params[:id])

    if @expense_report.update(expense_report_params)
      save_and_update_total_amount(@expense_report)
      redirect_to @expense_report, notice: 'Expense report updated successfully.'
    else
      render :edit
    end   
  end

  # DELETE /expense_reports/1 or /expense_reports/1.json
  def destroy
    @expense_report = current_user.expense_reports.find(params[:id])
    @expense_report.expenses.update_all(expense_report_id: nil)
    @expense_report.destroy
    redirect_to expense_reports_path, notice: 'Expense report deleted successfully.'
  end

  private
    def save_and_update_total_amount(expense_report)
      total_amount = 0
      expenses = current_user.expenses.where(id: expense_report_params[:expense_ids] || [])
      expenses.each { |expense| total_amount += expense.amount.to_i }
      expense_report.total_amount = total_amount
      expense_report.expenses = expenses
      expense_report.attributes = expense_report.attributes.except('name')
      expense_report.save
    end

    # Only allow a list of trusted parameters through.
    def expense_report_params
      params.require(:expense_report).permit(:name, :description, :total_amount, :user_id, expense_ids: [])
    end
end