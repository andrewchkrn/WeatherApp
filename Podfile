# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

post_install do |pi|
   pi.pods_project.targets.each do |t|
       t.build_configurations.each do |bc|
          bc.build_settings['ARCHS[sdk=iphonesimulator*]'] =  `uname -m`
       end
   end
end

target 'WeatherApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WeatherApp


pod 'SDWebImage'
pod 'GooglePlaces'
pod 'Alamofire', '~> 5.4.0'
pod 'AlamofireNetworkActivityLogger', '~> 3.4'

end
