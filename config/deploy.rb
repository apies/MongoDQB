require 'bundler/capistrano'

set :application, "mongodqb"
set :scm, "git"
set :repository, "git://github.com/apies/MongoDQB.git"
server "localhost", :web, :app, :db, :primary => true
ssh_options[:port] = 2222
ssh_options[:keys] = "~/.vagrant.d/insecure_private_key"

set :user, "vagrant"
set :group, "vagrant"
set :deploy_to, "/var/mongodqb"
set :use_sudo, false

set :deploy_via, :copy
set :copy_strategy, :export

set :unicorn_config, "#{current_path}/config/unicorn.rb"

set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"


namespace :deploy do
	task :start, :roles => :app, :except => { :no_release => true} do
		puts "start"
		run "cd #{current_path} \
		     && #{bundle_cmd} exec unicorn -c #{unicorn_config} -E #{rails_env} -D" 
	end
	task :stop, :roles => :app, :except => { :no_release => true} do
		#puts "stop"
		run "#{try_sudo} kill 'cat #{unicorn_pid}' " 
	end
	desc "Restart the application"
	task :restart, :roles => :app, :except => { :no_release => true} do
		#puts "restart"
		run "#{try_sudo} kill -s USR2 'cat #{unicorn_pid}'"
	end
	task :copy_in_database_yml do
		run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
	end
end