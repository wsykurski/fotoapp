json.array!(@users) do |user|
  json.extract! user, :id, :login, :mysingle_id
  json.url user_url(user, format: :json)
end
