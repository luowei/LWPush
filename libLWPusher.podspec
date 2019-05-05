#
# Be sure to run `pod lib lint libLWPusher.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'libLWPusher'
  s.version          = '1.0.0'
  s.summary          = 'A short description of libLWPusher.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/luowei/libLWPusher'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luowei' => 'luowei@wodedata.com' }
  s.source           = { :git => 'https://github.com/luowei/libLWPusher.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'libLWPusher/Classes/**/*'
  
  # s.resource_bundles = {
  #   'libLWPusher' => ['libLWPusher/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  # s.libraries = 'sqlite3','z','XG-SDK'
  # s.frameworks = 'CoreTelephony', 'SystemConfiguration'
  # s.vendored_libraries = 'Pod/libLWPusher/XGPush/libXG-SDK.a'
  # s.source_files = 'Pod/libLWPusher/XGPush/*.{h,m}'


  # 参考：
  # https://stackoverflow.com/questions/19481125/add-static-library-to-podspec
  # https://www.jianshu.com/p/5d987d82d4d9

  s.subspec 'XGPush' do |c|
      # c.public_header_files = 'libLWPusher/XGPush/XGPush.h'
      # c.dependency 'AFNetworking'
      # c.resources = 'libLWPusher/XGPush/Assets/*'
      c.source_files = 'libLWPusher/XGPush/*.{h,m}'
      c.preserve_paths = 'libLWPusher/XGPush/*.h'
      c.vendored_libraries = 'libLWPusher/XGPush/libXG-SDK.a'
      c.libraries = 'XG-SDK','sqlite3','z'
      c.frameworks = 'UIKit','CoreTelephony', 'SystemConfiguration'
      # c.frameworks = 'CoreTelephony', 'SystemConfiguration','UserNotifications'
      # c.xcconfig = {
      #   'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/#{s.name}/XGPush/**",
      #   'OTHER_LDFLAGS' => '$(inherited)'
      #   # 'OTHER_CFLAGS' => '$(inherited)'
      # }
    end


end
