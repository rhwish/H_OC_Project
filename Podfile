# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# dev tool hawkeye
def hawkeye
  pod 'MTHawkeye', :configurations => 'Debug'
  pod 'FLEX', :configurations => ['Debug']
  pod 'FBRetainCycleDetector', :configurations => ['Debug']
  pod 'fishhook', :configurations => ['Debug']
  pod 'CocoaLumberjack', '3.6.0', :configurations => ['Debug']
  pod 'MTAppenderFile', :configurations => ['Debug']
end

# H_OC_Project
target 'H_OC_Project' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for H_OC_Project

  hawkeye
  pod 'AFNetworking', '~> 4.0.1'
  pod 'SDWebImage', '~> 5.13.2'
  pod 'JJException', '~> 0.2.12'
  pod 'MyLayout', '~> 1.9.8'
  pod 'GKNavigationBar', '~> 1.8.0'

  # H_OC_ProjectTests
  target 'H_OC_ProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  # H_OC_ProjectUITests
  target 'H_OC_ProjectUITests' do
    # Pods for testing
  end

end
