#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'bundle/bundler/setup'
require_relative 'workflow_config.rb'
require 'alfred'

filter = ARGV[0].to_s.downcase

# config / data
config = WorkflowConfig.new

# get current resolution
current_resolution = config.get_current_resolution

# get resolution list
resolutions = config.get_resolutions

# removes current resolution
resolutions = resolutions.delete_if { |mode| mode['resolution'] == current_resolution['resolution'] }

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  # search filter if present
  resolutions.reject! do |mode|
    true unless mode['resolution'] =~ /#{filter}/
  end

  if resolutions.length > 0
    if filter =~ /^\s*$/
      # adds current resolution as non actionable item
      fb.add_item({
                      :title => "Current Resolution: #{current_resolution['resolution']} at #{current_resolution['dpi']}",
                      :subtitle => 'Select a new resolution from the list or type to search',
                      :arg => '',
                      :valid => 'no',
                  })
    end

    # iterates and performs search filter if present
    resolutions.each do |mode|
      fb.add_item({
                      #:uid => mode['id'],
                      :title => "Switch to #{mode['resolution']} at #{mode['dpi']}",
                      :subtitle => "Change resolution to #{mode['width']} width and #{mode['height']} height at #{mode['dpi']} mode",
                      :arg => mode['id'],
                      :valid => 'yes',
                  })
    end
  else
    # shows no result message
    fb.add_item({
                    :uid => '',
                    :title => 'No results for your search',
                    :subtitle => 'No screen resolution found for your input search',
                    :arg => '',
                    :valid => 'no',
                })
  end

  puts fb.to_xml()
end