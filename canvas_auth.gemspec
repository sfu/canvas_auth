$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "canvas_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "canvas_auth"
  s.version     = CanvasAuth::VERSION
  s.authors     = ["Patrick Chin"]
  s.email       = ["patchin@sfu.ca"]
  s.summary     = "Canvas REST API to check username/password."
  s.description = "Canvas REST API to check username/password."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2", "< 4.2"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
