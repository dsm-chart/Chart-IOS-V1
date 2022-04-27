# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Chart-IOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Chart-IOS

inhibit_all_warnings!

  target 'Chart-IOSTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Chart-IOSUITests' do
    # Pods for testing
  end

pod 'RxSwift', '6.5.0'
pod 'RxCocoa', '6.5.0'

pod 'Moya/RxSwift', '~> 15.0'
pod 'RxAlamofire'
pod 'Alamofire', '~> 5.5'
pod 'Kingfisher', '~> 7.0'
pod "RxGesture"
pod 'RxKeyboard'
pod 'SPIndicator'

pod 'Charts'
pod 'Then', '~> 2.7.0'
pod 'SnapKit', '~> 5.0.0'

pod 'FlexLayout'
pod 'PinLayout'

pod 'PanModal'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = 'YES'
    config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
  end
end

