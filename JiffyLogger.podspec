# Be sure to run `pod lib lint JiffyLogger.podspec' to ensure this is a
Pod::Spec.new do |s|
  s.name             = "JiffyLogger"
  s.version          = "1.0.1"
  s.summary          = "JiffyLogger is a realtime log and log viewing utility."
  s.description      = 'JiffyLogger allows you to capture and view events while away from your development environment.'

  s.homepage         = "https://github.com/jyaunches/JiffyLogger"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "jyaunches" => "jmyaunch@gmail.com" }
  s.source           = { :git => "https://github.com/jyaunches/JiffyLogger.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'JiffyLogger' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ObjectiveSugar'
end
