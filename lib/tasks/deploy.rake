task :deploy => ['deploy:migrate', 'deploy:restart']

namespace :deploy do
  APP_NAME = 'nprapp'
  task :migrate do
    puts 'Running db:migrations'
    puts `heroku rake db:migrate --app #{APP_NAME}`
  end
  task :restart do
    puts 'Restarting app servers ...'
    puts `heroku restart --app #{APP_NAME}`
  end
end
