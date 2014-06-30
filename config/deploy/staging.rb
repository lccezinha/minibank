set :stage, :staging
role :app, %w{cezer@104.131.240.101}
role :web, %w{cezer@104.131.240.101}
role :db, %w{cezer@104.131.240.101}
set :ssh_options, forward_agent: true