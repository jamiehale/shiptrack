# This file is part of ShipTrack.
#
# Copyright 2014 Jamie Hale <jamie@smallarmyofnerds.com>
#
# ShipTrack is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ShipTrack is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ShipTrack. If not, see <http://www.gnu.org/licenses/>.

Gem::Specification.new do |s|
  s.name        = 'shiptrack'
  s.version     = '0.0.2'
  s.date        = '2014-01-31'
  s.license     = 'GPLv3'
  s.summary     = "Sancorp Shipment Tracking"
  s.description = "Script for recording and tracking shipments."
  s.authors     = ["Jamie Hale"]
  s.email       = 'jamie@smallarmyofnerds.com'
  s.homepage    = 'http://smallarmyofnerds.com'
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "res/**/*", "COPYING", "*.md"]
  s.require_path = 'lib'
  s.executables << 'shiptrack'
  s.add_runtime_dependency 'launchy', '~> 2.4', '>= 2.4.2'
  s.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.1'
  s.add_development_dependency 'factory_girl', '~> 4.3', '>= 4.3.0'
end
