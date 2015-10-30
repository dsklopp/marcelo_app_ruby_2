#
# Cookbook Name:: marcelo_app_ruby_2
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt::default"
include_recipe 'build-essential'

package [ "git", "libsqlite3-dev" ]

directory "/srv/myapp" do
	owner 'root'
	group 'root'
	mode '755'
end

git 'rails app' do
	repository 'https://github.com/decareano/blogtutorial.git'
	destination "/srv/myapp"
end

execute 'bundle install' do
	command "cd /srv/myapp; bundle install"
end

execute 'run rails' do
	command 'cd /srv/myapp; rails server'
end