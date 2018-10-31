# Uncomment the next line to define a global platform for your project
 platform :ios, '9.2'

target 'OrganizationsMap' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
  inhibit_all_warnings!

  # Pods for OrganizationsMap
  pod 'ReactiveObjC'
  pod 'Mantle'

  target 'OrganizationsMapTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.2'
        end
    end
end
