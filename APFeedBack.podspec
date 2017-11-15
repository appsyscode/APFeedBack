#
# Be sure to run `pod lib lint APFeedBack.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "APFeedBack"
  s.version          = "0.1.1"
  s.summary          = "APFeedBack Library"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
Feedback to send iOS enabled developer NSLog file create .txt
                       DESC

  s.homepage         = "https://github.com/appsyscode/APFeedBack"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "appsyscode" => "info@techmobilesoft.com" }
  s.source           = { :git => "https://github.com/appsyscode/APFeedBack.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/appsyscode'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*'
#  s.resource_bundles = {
#    'APFeedBack' => ['Pod/Assets/*.png']
#  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.framework  = 'MessageUI'
  # s.dependency 'AFNetworking', '~> 2.3'
end
