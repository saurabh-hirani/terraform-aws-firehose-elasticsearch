require 'rubygems'
require 'bundler'
require 'rake'
require 'English'

def youre_behind?
  `git fetch >/dev/null 2>&1`
  behind = `git log ..origin/master --oneline`.split("\n").length > 0
  raise unless $CHILD_STATUS.exitstatus.zero?
  return behind
end

def youre_behind!
  if youre_behind?
    raise "ERROR: You're out of sync with the remote! Try 'git pull --rebase'"
  end
end

def current_version
  File.read('VERSION').strip
end

def bump(component)
  youre_behind!
  version = current_version

  # update the version
  new_version = nil
  chunks = version.split('.')

  if component == :patch
    chunks[-1] = (chunks.last.to_i + 1).to_s
  elsif component == :minor
    chunks[-2] = (chunks[-2].to_i + 1).to_s
    chunks[-1] = '0'
  else
    chunks[0] = (chunks[0].to_i + 1).to_s
    chunks[-2] = '0'
    chunks[-1] = '0'
  end

  new_version = chunks.join('.')
  File.open('VERSION', 'w') { |f| f.write(new_version) }

  `git add VERSION`
  `git commit -m "Version bump to #{new_version}"`
  `git tag -a v#{new_version} -m#{new_version}`
  raise 'Could not add tag' unless $CHILD_STATUS.exitstatus.zero?
  puts 'Version is now "%s"' % new_version
end

def bump_and_release component
  puts '------- Bumping version ----------'
  bump component
  youre_behind!

  puts '------- Pushing to repo ----------'
  status = system('git push')
  raise 'Push failed' unless status

  status = system('git push --tag')
  raise 'Tag push failed' unless status
end

desc 'Print the current version'
task :version do
  puts current_version
end

namespace :release do
  desc 'Release new major version'
  task :major do
    bump_and_release :major
  end

  desc 'Release new minor version'
  task :minor do
    bump_and_release :minor
  end

  task :patch do
    bump_and_release :patch
  end
end

desc 'Release a new patch version'
task release: %w[ release:patch ]
