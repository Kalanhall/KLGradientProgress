#
# Be sure to run `pod lib lint KLGradientProgress.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KLGradientProgress'
  s.version          = '1.0.1'
  s.summary          = '多色锥形渐变进度圆环'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  简介：
  公司业务实现锥形渐变进度圆环。
                       DESC

  s.homepage         = 'https://github.com/Kalanhall'
  s.screenshots     = 'https://github.com/Kalanhall/KLImagesSource/blob/master/WX20200324-104602.png', 'https://github.com/Kalanhall/KLImagesSource/blob/master/WX20200324-104615.png', 'https://github.com/Kalanhall/KLImagesSource/blob/master/WX20200324-104635.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kalanhall@163.com' => 'wujm002@galanz.com' }
  s.source           = { :git => 'https://github.com/Kalanhall/KLGradientProgress.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'KLGradientProgress/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KLGradientProgress' => ['KLGradientProgress/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
