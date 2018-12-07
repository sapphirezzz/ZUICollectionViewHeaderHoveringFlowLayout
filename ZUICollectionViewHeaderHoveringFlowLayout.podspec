#
# Be sure to run `pod lib lint ZUICollectionViewHeaderHoveringFlowLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZUICollectionViewHeaderHoveringFlowLayout'
  s.version          = '0.2.0'
  s.summary          = '用于UICollectionView实现任意Header置顶的FlowLayout.'

  s.description      = <<-DESC
用于UICollectionView实现任意Header置顶的FlowLayout.
                       DESC

  s.homepage         = 'https://github.com/sapphirezzz/ZUICollectionViewHeaderHoveringFlowLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zackzheng' => 'zhengzuanzhe@gmail.com' }
  s.source           = { :git => 'https://github.com/sapphirezzz/ZUICollectionViewHeaderHoveringFlowLayout.git', :tag => s.version.to_s }
  
  s.swift_version = '4.2'
  s.ios.deployment_target = '9.0'
  s.source_files = 'ZUICollectionViewHeaderHoveringFlowLayout/Classes/**/*'
  s.frameworks = 'UIKit'
end
