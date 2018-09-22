Pod::Spec.new do |s|
  s.name             = 'SiberianVIPER'
  s.version          = '3.1.0'
  s.summary          = 'SiberianVIPER is a bunch of protocols and classes that help in VIPER. See the example app and VIPERTemplates'
  s.description      = 'SiberianVIPER is a set of protocols and classes that help in VIPER. See the example app for reference. Take a look at https://github.com/SergeyPetrachkov/VIPERTemplates'

  s.homepage         = 'https://github.com/SergeyPetrachkov/SiberianVIPER'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sergey petrachkov' => 'petrachkovsergey@gmail.com' }
  s.source           = { :git => 'https://github.com/SergeyPetrachkov/SiberianVIPER.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'SiberianVIPER/SiberianVIPER/Classes/**/*'
end
