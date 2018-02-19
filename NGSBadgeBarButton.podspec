_release = "1.1"
_build = "1"

_version = _release + "." + _build #e.x. 1.2.3
_tag = "R" + _release + "/" + _version #e.x. R1.2/1.2.3

Pod::Spec.new do |s|
  s.name             = 'NGSBadgeBarButton'
  s.version          = _version
  s.swift_version    = '3.2'
  s.summary          = 'UIBarButton with red badge in corner'
  s.description      = 'UIBarButton subclass to provide option to set red badge on its corner. AutoLayout in action'

  s.homepage         = 'https://github.com/PauliusVindzigelskis/NGSBadgeBarButton'
  s.screenshot       = 'https://user-images.githubusercontent.com/2383901/36121468-e32e9756-100b-11e8-9e64-ddcd0d6e8514.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Paulius Vindzigelskis' => 'p.vindzigelskis@gmail.com' }
  s.source           = { :git => 'https://github.com/PauliusVindzigelskis/NGSBadgeBarButton.git', :tag => _tag }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Pod/*.{swift}'
  s.frameworks = 'UIKit'
end
