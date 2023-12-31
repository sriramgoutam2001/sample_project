class EmployeesController < ApplicationController
    def index
      @employees = Employee.all
    end
  
    def show
      @employee = Employee.find(params[:id])
    end
  
    def new
      @employee = Employee.new
    end
  
    def create
      @employee = Employee.new(employee_params)
      if @employee.save
        flash[:notice] = 'Employee has been successfully added.'
        redirect_to employees_path
      else
        render :new
      end
    end
  
    def edit
      @employee = Employee.find(params[:id])
    end
  
    def update
      @employee = Employee.find(params[:id])
  
      if @employee.update(employee_params)
        flash[:notice] = 'Employee details updated successfully.'
        redirect_to employees_path
      else
        render :edit
      end
    end
  
    def destroy
      @employee = Employee.find(params[:id])
      @employee.destroy
      flash[:notice] = 'Employee deleted successfully.'
      redirect_to employees_path
    end
  
    private
      def employee_params
        params.require(:employee).permit(:name, :emp_id, :dept, :emp_status)
      end
  end
  