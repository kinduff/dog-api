# The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
configure :development, :production do
  set :database_file, "config/database.yml"
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
