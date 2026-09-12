Pod::Spec.new do |s|
  s.name             = 'AdshiftSDK'
  s.version          = '2.0.1'
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

  # The framework is static, so CocoaPods links it without embedding it and
  # nothing inside it reaches the app bundle -- including the privacy manifest
  # Xcode reads when it builds the privacy report and when it enforces the
  # declared tracking domains. Shipping the manifest as a resource bundle as
  # well is what puts it where Xcode looks. Swift Package Manager embeds the
  # framework itself, so it needs none of this.
  s.resource_bundles = {
    'AdshiftSDK' => ['AdshiftSDK.xcframework/ios-arm64/AdshiftSDK.framework/PrivacyInfo.xcprivacy']
  }
  
  # Wymagane frameworki systemowe
  s.frameworks       = 'Foundation', 'UIKit', 'StoreKit', 'AdSupport', 'AppTrackingTransparency'
  
  # Ustawienia buildu
  s.pod_target_xcconfig = { 
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES'
  }
end

