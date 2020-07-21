Pod::Spec.new do |s|
  s.name         = "MJScaleMesureSDK"
  s.version      = "1.0.0"
  s.summary      = "Streams of values over time"
  s.description  = <<-DESC
                   MJTV sdk Cocoa frameworks.
                   DESC
  s.homepage     = "https://github.com/a123xiongwei/DemoApp"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = "MJScaleMesure"


  s.source       = { :git => "https://github.com/a123xiongwei/DemoApp.git", :tag => "#{s.version}" }
  s.source_files = 'TitanFMBase/Classes/**/*'
  s.public_header_files = "Classes/Custom/MJScaleService.h"
  s.module_name = 'MJScaleMesure'

  s.dependency 'IotLinkKit',
  s.dependency 'MBProgressHUD',
  s.dependency 'YYKit'
  s.dependency 'AFNetworking',
  s.dependency 'MJExtension',
  s.dependency 'ReactiveCocoa',
  s.dependency 'ReactiveViewModel'

end
