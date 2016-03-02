









Pod::Spec.new do |s|
  s.name     = "RXBannerView"
  s.version  = "0.3"
  s.license  = "MIT"
  s.summary  = "RXBannerView is a simple bannerView"
  s.homepage = "https://github.com/xzjxylophone/RXBannerView"
  s.author   = { 'Rush.D.Xzj' => 'xzjxylophoe@gmail.com' }
  s.social_media_url = "http://weibo.com/xzjxylophone"
  s.source   = { :git => 'https://github.com/xzjxylophone/RXBannerView.git', :tag => "v#{s.version}" }
  s.description = %{
    RXBannerView is a simple bannerView.
  }
  s.source_files = 'RXBannerView/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true
  s.platform = :ios, '7.0'
  s.dependency 'RXPageControl'
end






