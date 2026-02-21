Pod::Spec.new do |s|
  s.name             = 'AdshiftSDK'
  s.version          = '1.2.0'
  s.summary          = 'AdShift iOS SDK - Mobile Attribution & Analytics'
  
  s.description      = <<-DESC
    AdShift SDK enables mobile attribution, in-app event tracking,
    SKAdNetwork 4.0+ integration, deep linking, and GDPR/TCF 2.2
    compliance for iOS apps.
  DESC

  s.homepage         = 'https://adshift.com'
  s.documentation_url = 'https://dev.adshift.com/docs/ios-sdk'
  s.license          = { :type => 'Commercial', :text => 'Copyright (c) 2025 AdShift sp. z o.o. All rights reserved. https://www.adshift.com' }
  s.author           = { 'AdShift' => 'support@adshift.com' }
  
  s.source           = { 
    :http => "https://github.com/AdShift/ios-sdk/releases/download/v#{s.version}/AdshiftSDK.xcframework.zip"
  }
  
  s.platform         = :ios, '15.0'
  s.swift_version    = '5.0'
  
  s.vendored_frameworks = 'AdshiftSDK.xcframework'
  
  # Wymagane frameworki systemowe
  s.frameworks       = 'Foundation', 'UIKit', 'StoreKit', 'AdSupport', 'AppTrackingTransparency'
  
  # Ustawienia buildu
  s.pod_target_xcconfig = { 
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES'
  }
end

