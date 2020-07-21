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

  s.dependency 'IotLinkKit', '1.2.0'
  s.dependency 'MBProgressHUD', '0.9.1'
  s.dependency 'YYKit'
  s.dependency 'AFNetworking', '~> 3.2.0'
  s.dependency 'MJExtension', '~> 3.0.13'
  s.dependency 'ReactiveCocoa',
  s.dependency 'ReactiveViewModel'

end
