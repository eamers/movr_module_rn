require 'json'

def use_movr_module_rn! (options={})
  package = JSON.parse(File.read(File.join(__dir__, "../package.json")))
  packageName = package['name']
  prefix = options[:path] ||= "../node_modules/#{packageName}"

  pod 'Flutter', :podspec => "#{prefix}/modules/ios/framework/Debug/Flutter.podspec"
  pod 'FlutterModuleFrameworks-Debug',
    :configuration => 'Debug',
    :podspec => "#{prefix}/ios/Podspecs/MovrModuleRn-Debug.podspec"
  pod 'FlutterModuleFrameworks-Release',
    :configuration => 'Release',
    :podspec => "#{prefix}/ios/Podspecs/MovrModuleRn-Release.podspec"
end

def movr_module_rn_post_install(installer)
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'AUDIO_SESSION_MICROPHONE=0'
      ]
    end
  end
end