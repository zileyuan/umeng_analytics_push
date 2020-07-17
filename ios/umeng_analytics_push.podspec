#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'umeng_analytics_push'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.static_framework = true

  s.dependency 'UMCCommon', '2.1.1'
  s.dependency 'UMCAnalytics', '6.0.5'
  s.dependency 'UMCPush', '3.2.4'
  s.dependency 'UMCCommonLog', '2.0.0'

  s.ios.deployment_target = '9.0'
end

