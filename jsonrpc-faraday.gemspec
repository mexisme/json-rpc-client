# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jsonrpc/version"

Gem::Specification.new do |spec|
  spec.name          = "jsonrpc-faraday"
  spec.version       = JsonRpc::VERSION
  spec.authors       = ["mexisme"]
  spec.email         = ["wildjim+dev@kiwinet.org"]

  spec.summary       = "A simple JSON-RPC library, which defaults to using Faraday for the http-client wrapper."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/mexisme/json-rpc-client"

  # Prevent pushing this gem to RubyGems.org by setting "allowed_push_host", or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # else
  #   fail "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "logging"
  spec.add_runtime_dependency "typhoeus"
  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "faraday_middleware"
  spec.add_runtime_dependency "multi_json"

  spec.add_development_dependency "bundler", "~> 1"
  spec.add_development_dependency "rake", "~> 12"
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "simplecov", "~> 0.19"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "pry-byebug"
end
