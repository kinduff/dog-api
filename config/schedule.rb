set :output, {:error => '~/Desktop/z.error.log', :standard => '~/Desktop/z.standard.log'}
env :PATH, '~/.rbenv/shims:/usr/local/bin:/usr/bin:/bin'
env :GEM_PATH, ENV['GEM_PATH']

every 1.day, :at => '12:00 pm' do
  rake "bark"
end
