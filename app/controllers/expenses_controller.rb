class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  around_action :switch_locale



  # GET /expenses
  # GET /expenses.json
  def index
    require 'csv'
    #@expenses = Expense.all
    @expenses = Expense.where(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.csv do
        vals = CSV.generate do |csv|
          csv  << ["Category","Amount","Date"]
          @expenses.each do |expense|
            csv << [expense.category.category_name,expense.amount,expense.expense_time.to_date]
          end
        end
        send_data(vals, :filename => "expense_report.csv")
      end
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    #@cat_names = ''
    #Category.find_each do |rec|
    #  @cat_names << rec.category_name << ' '
    #end
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
   # @expense = Expense.new(**expense_params, user_id: current_user.id, category_id: Category.find_by_category_name)
    @expense = Expense.new(**expense_params, user_id: current_user.id)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:amount, :comment, :expense_time, :category_id)
    end

    def switch_locale(&action)
      locale = cookies[:locale] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end
  
end
