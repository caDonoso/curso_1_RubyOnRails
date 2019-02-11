json.extract! comment, :id, :user_id, :mountain_id, :body, :created_at, :updated_at
json.url comment_url(comment, format: :json)

json.user do
	json.email @comment.user.email
end