

Pod::Spec.new do |s|
  s.name             = 'ImageRecognitionDemo'
  s.version          = '0.1.0'
  s.summary           = 'ImageRecognitionDemo ceshi shiyong'
  s.homepage         = 'https://github.com/liboloveguo/ImageRecognitionDemo'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liboloveguo' => 'ag970898664@163.com' }
  s.source           = { :git => 'https://github.com/liboloveguo/ImageRecognitionDemo.git', :tag => s.version.to_s }

  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

#s.public_header_files = 'ImageRecognitionDemo/Classes/**/*.{h}'
  s.source_files = 'ImageRecognitionDemo/Classes/**/*.{h,m}'
  s.vendored_frameworks = 'ImageRecognitionDemo/Classes/lib/*.{framework}'
  
  #s.resource_bundles = {
  # 'ImageRecognitionDemo' => ['ImageRecognitionDemo/Assets/**/*.{png,jpg}','ImageRecognitionDemo/Classes/**/*.{xib}']
  #}
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  #s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
  
end
