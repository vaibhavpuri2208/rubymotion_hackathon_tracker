# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
require 'motion-cocoapods'


Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'movie_list'

  app.frameworks = ['CoreLocation', 'MapKit']

  app.pods do
    dependency 'JSONKit'
  end

end
