Pod::Spec.new do |s|
  s.name         = "ZZFLEX"
  s.version      = "1.2.0"
  s.platform     = :ios, "8.0"
  s.summary      = "一个iOS UI敏捷开发框架，基于UIKit实现，主要包含常用控件的链式API拓展、一个数据驱动的列表框架、一个事件处理队列。"
  s.description  = <<-DESC
  目前ZZFLEX主要包含以下5个功能模块：
  UIView+ZZFLEX：为UIKit中常用的控件增加了链式API拓展，使得控件属性、事件、约束的设置一气呵成（视图的模块化）；
  ZZFLEXCollectionViewController：数据驱动的列表页框架，基于UICollectionView，可以简洁方便的构建数据展示类的列表页，并实现了cell/view的与collectionView的解耦（cell的模块化）；
  ZZFLEXAngel：ZZFLEXCollectionViewController逻辑的抽离出的一个视图控制器，不在继承自VC使其更加轻量，同时支持tableView、collectionView；
  ZZFLEXEditExtension：为ZZFLEXAngel和ZZFLEXCollectionViewController增加了一种处理编辑类页面的能力；
	ZZFLEXRequestQueue：一个事件处理队列，设计的初衷为解决复杂页面多接口请求UI刷新顺序的问题。
                   DESC

  s.author       = { "libokun" => "libokun@126.com" }
  s.homepage     = "https://github.com/tbl00c/ZZFLEX"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.source       = { :git => "https://github.com/tbl00c/ZZFLEX.git", :tag => s.version }
  s.frameworks   = 'UIKit', 'CoreFoundation', 'Foundation'
  s.dependency 'Masonry'

  s.requires_arc = true
  s.public_header_files = "ZZFLEX/**/*.{h}"
  s.source_files = "ZZFLEX/**/*.{h,m,mm}"

end
