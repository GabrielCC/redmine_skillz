require "redmine"

# Patches to the Redmine core.
ActionDispatch::Callbacks.to_prepare do 
  require_dependency 'user'
  require 'patches/user_patch'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless User.included_modules.include? UserPatch
    User.send(:include, UserPatch)
  end
end

Redmine::Plugin.register :redmine_skillz do
  name 'Redmine Skillz plugin'
  author 'Gabriel Croitoru'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
