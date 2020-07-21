

Pod::Spec.new do |spec|

  spec.name         = "TitanFMBase"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of TitanFMBase."

  spec.homepage     = "http://EXAMPLE/TitanFMBase"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  
  s.author        = { 'CoderTitan' => 'quanjunt@163.com' } #作者
  s.platform      = :ios, '8.0' #支持的平台
  s.requires_arc  = true #arc和mrc选项
 
  s.ios.vendored_frameworks = 'TKBase/TKBase.framework' # 依赖的第三方/自己的framework

    #依赖的第三方的或者自己的静态库文件必须以lib为前缀进行命名，否则会出现找不到的情况，这一点非常重要

    #平台信息
    s.platform      = :ios, '8.0'
    s.ios.deployment_target = '8.0'

    #文件配置项
    s.source        = { :git => 'https://github.com/CoderTitan/TitanModel.git', :tag => s.version.to_s }
    #配置项目的目标路径，如果不是本地开发，pod init/update会从这个路去拉去代码

    s.source_files = 'TitanFMBase/Classes/**/*' #你的源码位置
    s.resources     = ['TitanFMBase/Assets/*'] #资源，比如图片，音频文件等
    s.public_header_files = 'TitanFMBase/Classes/Custom/MJScaleService.h'   #需要对外开放的头文件

    #依赖的项目内容 可以多个
    s.dependency 'IotLinkKit', '1.2.0'
    s.dependency 'MBProgressHUD', '0.9.1'
    s.dependency 'YYKit'
    s.dependency 'AFNetworking', '~> 3.2.0'
    s.dependency 'MJExtension', '~> 3.0.13'
    s.dependency 'ReactiveCocoa', :git => 'https://github.com/zhao0/ReactiveCocoa.git', :tag => '2.5.2'
    s.dependency ''ReactiveViewModel'
  

end
