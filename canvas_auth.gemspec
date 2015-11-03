$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "canvas_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "canvas_auth"
  s.version     = CanvasAuth::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of CanvasAuth."
  s.description = "TODO: Description of CanvasAuth."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2", "< 4.2"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
