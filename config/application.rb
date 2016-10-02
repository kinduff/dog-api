# Development
configure :development do
  set :show_exceptions, true
end

# Production
configure :production do
  set :show_exceptions, false
end
