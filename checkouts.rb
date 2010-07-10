#!/usr/bin/env ruby

repos = {
  :blog => 'git@github.com:noahgibbs/blog.git',
  :www_static => 'git@git.assembla.com:angelbobwww.git',
  :refactor_it => 'git@github.com:noahgibbs/refactor_it.git',
  :wantmyjob => nil,
  :shannasdaddy => nil,#'ssh://angelbob@arch.angelbob.com/home/angelbob/src/master/shannasdaddy.git',
  :webconf => 'git@github.com:noahgibbs/webconf.git',
}

WebRoot = File.join(File.dirname(__FILE__), "..")

# refresh all repositories
repos.each do |repo_name, repo_path|
  puts "Refreshing #{repo_name}"
  Dir.chdir File.join(WebRoot, repo_name.to_s)
  system "git pull origin master" if repo_path
  system "touch tmp/restart.txt"
  system "git status"
end
