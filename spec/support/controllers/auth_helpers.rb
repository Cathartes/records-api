module AuthHelpers
  def authenticate_user(user)
    token = user.authentication_tokens.first || user.authentication_tokens.create!
    request.headers.merge! 'X-USER-UID' => user.email, 'X-USER-TOKEN' => token.body
  end
end

RSpec.configure do |c|
  c.include AuthHelpers
end
