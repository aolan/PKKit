#
# Be sure to run `pod lib lint PKKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PKKit'
  s.version          = '0.1.0'
  s.summary          = 'PKKit.'
  s.description      = <<-DESC
                        常用的开发组件.
                       DESC

  s.homepage         = 'https://github.com/aolan/PKKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'adcaowei@163.com' => 'adcaowei@163.com' }
  s.source           = { :git => 'https://github.com/aolan/PKKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.subspec 'PKUtil' do |util|
    util.source_files = 'PKKit/Classes/PKUtil/*'
    util.public_header_files = 'PKKit/Classes/PKUtil/*.h'
  end

  s.subspec 'PKExtension' do |extension|
    extension.source_files = 'PKKit/Classes/PKExtension/*'
    extension.public_header_files = 'PKKit/Classes/PKExtension/*.h'
  end

  s.subspec 'PKNetwork' do |network|
    network.source_files = 'PKKit/Classes/PKNetwork/*'
    network.public_header_files = 'PKKit/Classes/PKNetwork/*.h'
  end
  
  s.subspec 'PKMap' do |map|
    map.source_files = 'PKKit/Classes/PKMap/*'
    map.public_header_files = 'PKKit/Classes/PKMap/*.h'
    map.ios.frameworks = 'MapKit'
    map.dependency 'Masonry', '~> 1.0.2'
  end

end
