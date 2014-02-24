#!/usr/bin/env ruby
# encoding: utf-8

width, height = ARGV[0].split 'x'

result = system("./setresx -w #{width} -h #{height}");

unless result
  `/usr/bin/afplay /System/Library/Sounds/Funk.aiff`
  exit 1
end

print ARGV[0]
