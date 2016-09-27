
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '7.0'
use_frameworks!

def pods
    pod 'LFLiveKit', :git => 'https://github.com/LaiFengiOS/LFLiveKit.git'
    pod 'AFNetworking', '~> 3.1.0'
    pod 'ReactiveCocoa', '~> 2.5'
    pod 'YYModel', '~> 1.0.4'
    pod 'SVProgressHUD', '~> 2.0.3'
    pod 'SDWebImage', '~> 3.8.1'
    pod 'Masonry', '~> 1.0.1'
    pod 'KMNavigationBarTransition', '~> 0.0.10'
end

target 'IFQLive' do
    pods
end


post_install do |installer|
    puts 'Allow app extension api only:'
    installer.pods_project.targets.each do |target|
        case target.name
            when 'Base64', 'SocketRocket'
            target.build_configurations.each do |config|
                config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'YES'
                puts 'X...' + target.name
            end
            else
            puts '....' + target.name
        end
    end
end
