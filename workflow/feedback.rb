#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'bundle/bundler/setup'
require 'alfred'

filter = ARGV[0].to_s.downcase

# get current resolution
current_resolution = {}
`./setresx -ld`.chomp("\n")[12..-2].split(', ').each do |opt|
  opt = opt.split(/\s*=\s*/)
  current_resolution[opt[0]] =opt[1]
end

# get full resolution list from cli app, and parse data into array of hashes
modes = `./setresx --modes`.chomp("\n").split("\n").map do |line|
  mode = {}
  line[7..-2].split(', ').each { |opt| opt = opt.split(/\s*=\s*/); mode[opt[0]] = opt[1] }
  mode['width'] = mode['resolution'].split('x')[0]
  mode['height'] = mode['resolution'].split('x')[1]
  mode['dpi'] = mode['scale'] == '2.0' ? 'HiDPI' : 'normal resolution'
  mode['id'] = "#{mode['resolution']}x#{mode['scale']}"
  mode
end

# removes normal resolutions that are available as HiDPI
modes.reject! do |mode|
  false if mode['scale'] == '2.0'
  true if mode['scale'] == '1.0' && modes.any? { |m| m['id'] == "#{mode['width']}x#{mode['height']}x2.0" }
end

# removes current resolution
modes = modes.delete_if { |mode| mode['resolution'] == current_resolution['resolution'] }


Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  # iterates and performs search filter if present
  modes.each do |mode|
    unless filter =~ /^\s*$/
      next unless mode['resolution'] =~ /#{filter}/ || mode['dpi'] =~ /#{filter}/
    end

    fb.add_item({
                    :uid => mode['id'],
                    :title => "Switch to #{mode['resolution']} at #{mode['dpi']}",
                    :subtitle => "Change resolution to #{mode['width']} width and #{mode['height']} height at #{mode['dpi']} mode",
                    :arg => mode['id'],
                    :valid => 'yes',
                })

  end

  # shows no result message
  if fb.to_xml().to_s == '<items/>'
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