json.extract! expense, :id, :amount, :comment, :expense_time, :created_at, :updated_at
json.url expense_url(expense, format: :json)
