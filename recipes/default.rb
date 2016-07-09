#
# Cookbook Name:: git-daemon
# Recipe:: default
#
# Copyright 2014, kadoyama.keisuke@gmail.com
#
# All rights reserved - Do Not Redistribute
#

%w(
  git-daemon
  xinetd
).each do |pkg|
  package pkg
end

group "#{node['git-daemon']['group']}"

user "#{node['git-daemon']['user']}" do
  supports :manage_home => true
  gid "#{node['git-daemon']['group']}"
  home "/home/#{node['git-daemon']['user']}"
  shell "/usr/bin/git-shell"
  password nil
end

directory "#{node['git-daemon']['repo_dir']}"

node['git-daemon']['repos'].each do |repo|
  bash "create #{repo}" do
    user "#{node['git-daemon']['user']}"
    group "#{node['git-daemon']['group']}"
    cwd "#{node['git-daemon']['repo_dir']}"
    code <<-EOC
      git init --bare --shared #{node['git-daemon']['repo_dir']}/#{repo}.git
    EOC
    creates "#{node['git-daemon']['repo_dir']}/#{repo}.git"
  end
end

template "/etc/xinetd.d/git" do
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[xinetd]"
end

service "xinetd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
