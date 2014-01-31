Gem::Specification.new do |s|
  s.name        = 'shiptrack'
  s.version     = '0.0.1'
  s.date        = '2014-01-30'
  s.summary     = "Sancorp Shipment Tracking"
  s.description = "Script for recording and tracking shipments."
  s.authors     = ["Jamie Hale"]
  s.email       = 'jamie@smallarmyofnerds.com'
  s.homepage    = 'http://smallarmyofnerds.com'
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "res/**/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
  s.executables << 'shiptrack'
  s.add_runtime_dependency 'launchy', '>= 2.4.2'
  s.add_development_dependency 'rspec', '>= 2.14.1'
end