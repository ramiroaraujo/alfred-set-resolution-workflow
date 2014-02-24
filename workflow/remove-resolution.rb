#!/usr/bin/env ruby
# encoding: utf-8

require 'workflow_config.rb'

resolution_id = ARGV[0]
config = WorkflowConfig.new
resolution = config.get_resolution resolution_id
config.remove_resolution resolution_id

print resolution['resolution']
