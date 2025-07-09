# Podspec for BlueConicClient
Pod::Spec.new do |spec|

    # BlueConic General
    spec.name               = 'BlueConicClient'
    spec.version            = '5.0.0'
    spec.license            = { :type => 'Commercial', :file => 'LICENSE' }
    spec.swift_version      = '5.8.1'
    spec.homepage           = 'https://blueconic.com'
    spec.authors            = { 'BlueConic' => 'info@blueconic.com' }
    spec.summary            = 'The BlueConicClient Framework provides the basis for communication with BlueConic.'
    spec.documentation_url  = 'https://support.blueconic.com/hc/en-us/articles/202527912-BlueConic-SDK-for-iOS'
    spec.changelog          = 'https://github.com/blueconic/blueconic-ios-sdk/blob/main/CHANGELOG.md'

    # BlueConic Resources
    spec.resources = ['BlueConicClient.xcframework/ios-arm64/*.{png}', 'BlueConicClient.xcframework/ios-arm64/*/*.{png}']

    # BlueConic Sources
    spec.platform           = :ios, '12.0'
    spec.source             = { :git => 'https://github.com/blueconic/blueconic-ios-sdk.git', :tag => "#{spec.version}" }
    spec.default_subspec    = 'Core'

    # Core Subspec
    spec.subspec 'Core' do |core|
        core.preserve_paths = 'BlueConicClient.xcframework'
        core.vendored_frameworks = 'BlueConicClient.xcframework'
    end
end
