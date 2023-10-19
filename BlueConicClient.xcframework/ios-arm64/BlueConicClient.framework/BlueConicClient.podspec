# Podspec for BlueConicClient
Pod::Spec.new do |spec|

# BlueConic General
spec.name          = 'BlueConicClient'
spec.version       = '3.0.0'
spec.license       = { :type => 'Commercial' }
spec.swift_version = '5.8.1'
spec.homepage      = 'https://blueconic.com'
spec.authors       = { 'BlueConic' => 'info@blueconic.com' }
spec.summary       = 'The BlueConicClient Framework provides the basis for communication with BlueConic.'

# BlueConic Sources
spec.platform     = :ios, '12.0'
spec.source     = { :http => 'https://download.blueconic.com/cocoapod/BlueConic-iOS-SDK-3.0.0-Source.zip', :flatten => true}
spec.source_files = 'BlueConicClient/BlueConicClient.h'
spec.default_subspec = 'main'

# BlueConic Resources
spec.resources = ['BlueConicClient/Resources/*.{png}', 'BlueConicClient/Resources/**/*.{png}']

# main
# has dependencies on all
spec.subspec 'main' do |sm|
    sm.source_files = 'BlueConicClient/**/*'
    sm.exclude_files = 'BlueConicClient/Info.plist', 'BlueConicClient/Resources/**/*'
end
end
