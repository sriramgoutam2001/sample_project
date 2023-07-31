class CommentsController < ApplicationController
  before_action :find_expense
  before_action :find_comment, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.expense = @expense
    if @comment.save
      flash[:notice] = 'Comment has been successfully added.'
      redirect_to expense_comments_path(@expense)
    else
      puts @comment.errors.full_messages.inspect
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment details updated successfully.'
      redirect_to expense_comments_path(@expense)
    else
      puts @comment.errors.full_messages.inspect
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = 'Comment deleted successfully.'
    redirect_to expense_comments_path(@expense)
  end

  private

    def find_expense  
      @expense = Expense.find(params[:expense_id])
    end

    def find_comment
      @comment = current_user.admin ? Expense.find(params[:expense_id]).comments.find(params[:id]) : current_user.expenses.find(params[:expense_id]).comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :expense_id)
    end
end
