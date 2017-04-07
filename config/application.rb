 require "bundler"
Bundler.setup(:default)
Bundler.require(:default)

$LOAD_PATH.unshift File.expand_path("../../app", __FILE__)

require 'active_support/all'
require 'singleton'
require 'classes/text_processor'
require 'classes/document'
require 'classes/klass_examples'
require 'classes/examples'
require 'classes/classifier'
