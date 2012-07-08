#!/usr/bin/env rake
require "bundler/gem_tasks"

desc "Open an pry session preloaded with this library"
task :console do
  sh "pry -rubygems -I lib -r odf/converter.rb"
end