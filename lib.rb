#!/usr/bin/env ruby

lib_path = File.dirname(__FILE__) + "/lib"
libfiles = lib_path + "/**/*.rb"
Dir[libfiles].sort.each do |fname|
  rname = File.basename(fname, '.rb')
  require rname
end
