set :stage, :production
role :app, %w[cezer@162.243.227.29]
set :ssh_options, forward_agent: true