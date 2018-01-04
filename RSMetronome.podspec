Pod::Spec.new do |s|
  s.name = 'RSMetronome'
  s.version = '1.1'
  s.license = 'MIT'
  s.summary = 'A collection of helper functions to layout elements in Swift'
  s.homepage = 'https://github.com/roelspruit/RSMetronome'
  s.authors = { 'Roel Spruit' => 'roel@roelspruit.com' }
  s.source = { :git => 'https://github.com/roelspruit/RSMetronome.git', :tag => s.version }

  s.ios.deployment_target = '9.1'

  s.source_files = 'Source/*'

  s.requires_arc = true
end