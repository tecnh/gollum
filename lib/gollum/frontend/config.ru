#!/usr/bin/ruby
require 'rubygems'
require 'gollum/frontend/app'

system("which git") or raise "Looks like I can't find the git CLI in your path.\nYour path is: #{ENV['PATH']}"

gollum_path = '/var/www/wiki.tecnh.com' # CHANGE THIS TO POINT TO YOUR OWN WIKI REPO

disable :run

configure :development, :staging, :production do
 set :raise_errors, true
 set :show_exceptions, true
 set :dump_errors, true
 set :clean_trace, true
end

Precious::App.set(:gollum_path, gollum_path)

run Precious::App
