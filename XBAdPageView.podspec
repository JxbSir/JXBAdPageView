Pod::Spec.new do |s|

  s.name         = "JXBAdPageView"
  s.version      = "1.0"
  s.summary      = "An ad page view."
  s.homepage     = "https://github.com/JxbSir"
  s.license      = "Peter"
  s.author       = { "Peter" => "i@jxb.name" }
  s.requires_arc = true
  s.source       = { :git => "https://github.com/JxbSir/JXBAdPageView.git"  }
  s.source_files = "XBAdPageView/JXBAdPageView/*.{h,m}"
  s.public_header_files = 'XBAdPageView/JXBAdPageView/JXBAdPageView.h'
  s.frameworks   = 'UIKit'
end
