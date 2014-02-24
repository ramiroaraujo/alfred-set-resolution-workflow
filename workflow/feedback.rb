#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'bundle/bundler/setup'
require 'alfred'

filter = ARGV[0].to_s.downcase

modes = `./setresx --modes`.chomp("\n").split("\n").map do |line|
  mode = {}
  line[7..-2].split(', ').each { |opt| opt = opt.split(/\s*=\s*/); mode[opt[0]] = opt[1] }
  mode['width'] = mode['resolution'].split('x')[0]
  mode['height'] = mode['resolution'].split('x')[1]
  mode['dpi'] = mode['scale'] == '2.0' ? 'HiDPI' : 'normal resolution'
  mode
end

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  modes.each do |mode|
    unless filter =~ /^\s*$/
      next unless mode['resolution'] =~ /#{filter}/ || mode['dpi'] =~ /#{filter}/
    end

    fb.add_item({
                    :uid => '',
                    :title => "Switch to #{mode['resolution']} at #{mode['dpi']}",
                    :subtitle => "Change resolution to #{mode['width']} width and #{mode['height']} height at #{mode['dpi']} mode",
                    :arg => mode['resolution'],
                    :valid => 'yes',
                })

  end

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