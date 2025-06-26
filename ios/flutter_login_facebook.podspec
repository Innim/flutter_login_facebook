#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_login_facebook.podspec' to validate before publishing.
#

# Get version from pubspec.yaml
require 'yaml'

pubspec = YAML.load_file(File.join('..', 'pubspec.yaml'))
library_version = pubspec['version'].gsub('+', '-')

# Pod spec
Pod::Spec.new do |s|
  s.name             = 'flutter_login_facebook'
  s.version          = library_version
  s.summary          = 'Login via Facebook for Flutter projects.'
  s.description      = <<-DESC
Login via Facebook for Flutter projects.
                       DESC
  s.homepage         = 'https://github.com/Innim/flutter_login_facebook'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Innim' => 'developer@innim.org' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'FBSDKLoginKit', '18.0.0'
  s.platform = :ios
  s.ios.deployment_target = '12.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
