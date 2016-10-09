#
# Be sure to run `pod lib lint Badgeable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Badgeable'
  s.version          = '0.1.0'
  s.summary          = 'Everything can display badge.'
  s.description      = <<-DESC
Badgeable can display badge icon any UIView and UIBarButtonItem.
It is a protocol with default implementation written in Swift 3.0.
Just conforms Badgeable protocol and assign 'badgeCount' property. That's it.
                       DESC
  s.homepage         = 'https://github.com/gwangpa/Badgeable'
  s.screenshots      = 'https://github.com/gwangpa/Badgeable/blob/master/Screenshots/screenshot-001.png?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel KIM' => 'gwangpa@gmail.com' }
  s.source           = { :git => 'https://github.com/gwangpa/Badgeable.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'Badgeable/Classes/**/*'
  
end
