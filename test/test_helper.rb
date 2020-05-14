$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require_relative "../lib/node_observer_impl"
require "minitest/autorun"
