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

package [ "git", "libsqlite3-dev", "nodejs" ]

%w(git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev 
	libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev
	python-software-properties libffi-dev).each do |pack|
	package pack
end

directory "/srv/myapp" do
	owner 'root'
	group 'root'
	mode '755'
end

file '/srv/myapp/a_file' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

script "running a BASH script" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    echo Hello World    
    echo My name is marcelo
  EOH
end

cookbook_file "/srv/myapp/a_shell_script.sh" do
  source "a_shell_script.sh"
  mode 0755
end

execute "install shell script" do
  command "sh /srv/myapp/a_shell_script.sh"
end

template "/etc/afile.sh" do
	source "afile.sh.erb"
	variables ({
		name: 'Marcelo'
	})
end

git 'rails app' do
	repository 'https://github.com/decareano/blogtutorial.git'
	destination "/srv/myapp"
end

execute 'bundle install' do
	command "cd /srv/myapp; bundle install"
end

execute 'rake db:create' do
	command "cd /srv/myapp; bundle exec rake db:create"
end

execute 'rake db:migrate' do
	command "cd /srv/myapp; bundle exec rake db:migrate"
end

execute 'rake db:seed' do
	command "cd /srv/myapp; bundle exec rake db:seed"
end

#execute "kill rails" do
 #command "cd /srv/myapp"
 #not_if '[ `ps -ef | grep rails` -lt 2 ]'
#end

#execute "start rails" do
 #command "cd /srv/myapp; rails server -b 192.168.17.19 -d"
#end

execute "kill rails" do
	command "cd /srv/myapp; kill `ps -ef | grep rails | grep -v grep | awk '{print $2}' | tr '\n' ' '`"
	not_if '[ `ps -ef | grep rails | grep -v grep | wc -l` -lt 1 ]'
end

execute "start rails" do
 command "cd /srv/myapp; rails server -b 192.168.17.19 -d"
end
