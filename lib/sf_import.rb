$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "singleton"
require "csv"

require "sf_import/config"

require "sf_import/insert"

require "sf_import/objects/sf_object"
require "sf_import/objects/contact"

