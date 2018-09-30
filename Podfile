platform :ios, '10.0'

target 'CurrencyConverter' do
  use_frameworks!

   # Network
   pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire', :branch => 'alamofire5'

   # Utils
   pod 'Fabric',  '~> 1.7.2'
   pod 'Crashlytics', '~> 3.9.3'

   # UI
   pod 'DifferenceKit', '~> 0.5.3'
   pod 'Collections', :git => 'https://github.com/Tayphoon/Collections.git', :commit => 'c221b45'
   pod 'IsoCountryCodes', :git => 'https://github.com/Tayphoon/IsoCountryCodes.git', :commit => 'a5252cb'


  target 'CurrencyConverterTests' do
    inherit! :search_paths

    pod 'OHHTTPStubs/Swift', '~> 6.1.0'
  end

  #Fix DeepDiff version not set
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if ['DifferenceKit'].include? target.name
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '4.0'
              end
          end
      end
  end
end
