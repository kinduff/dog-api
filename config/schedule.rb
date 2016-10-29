set :output, {:error => '~/z.error.log', :standard => '~/z.standard.log'}
env :PATH, '~/.rbenv/shims:/usr/local/bin:/usr/bin:/bin'
env :GEM_PATH, ENV['GEM_PATH']
env :RACK_ENV, ENV['RACK_ENV']

every 1.day, :at => '12:00 pm' do
  rake "bark"
end
