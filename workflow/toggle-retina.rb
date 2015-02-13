#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'bundle/bundler/setup'
require_relative 'workflow_config.rb'

current_display = 0

current_resolution = WorkflowConfig.new.get_current_resolution current_display

width = current_resolution[:width]
height = current_resolution[:height]
bits = current_resolution[:bits]
hidpi = current_resolution[:hidpi] ? '' : 'h'

`./resolution-cli set #{current_display} #{width}x#{height}@#{bits}#{hidpi}`; result= $?.success?

unless result
  `/usr/bin/afplay /System/Library/Sounds/Funk.aiff`
  exit 1
end

print current_resolution[:hidpi] ? 'off' : 'on'
