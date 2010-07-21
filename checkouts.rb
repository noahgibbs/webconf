#!/usr/bin/env ruby

repos = {
  :blog => 'git@github.com:noahgibbs/blog.git',
  :www_static => 'git@git.assembla.com:angelbobwww.git',
  :refactor_it => 'git@github.com:noahgibbs/refactor_it.git',
  :wantmyjob => nil,
  :shannasdaddy => nil,#'ssh://angelbob@arch.angelbob.com/home/angelbob/src/master/shannasdaddy.git',
  :webconf => 'git@github.com:noahgibbs/webconf.git',
  "cheaptoad-catcher".to_sym => 'git@github.com:noahgibbs/cheaptoad-catcher.git',
}

WebRoot = File.join(File.expand_path(File.dirname(__FILE__)), "..")

repos.each do |repo_name, repo_path|
  unless File.exists? File.join(WebRoot, repo_name.to_s)
    Dir.chdir WebRoot
    system "git clone #{repo_path}"
  end
end

# refresh all repositories
repos.each do |repo_name, repo_path|
  puts "Refreshing #{repo_name}"
  this_dir = File.join(WebRoot, repo_name.to_s)
  Dir.chdir this_dir
  system "git pull origin master" if repo_path
  system "touch tmp/restart.txt" if File.exists?(File.join(this_dir, "tmp"))
  system "git status"
end
