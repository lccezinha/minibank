set :stage, :production
set :branch, 'master' # vai pegar da staging
role :app, %w{cezer@162.243.227.29}
role :web, %w{cezer@162.243.227.29}
role :db, %w{cezer@162.243.227.29}
set :ssh_options, forward_agent: true