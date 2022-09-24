# movr_module_rn.podspec

require './ios/Podspecs/common'

Pod::Spec.new do |s|
  setCommonProps(s)
  s.name         = "MovrModuleRn"
  s.description  = <<-DESC
                  movr_module_rn
                   DESC
  s.source_files = "ios/**/*.{h,c,cc,cpp,m,mm,swift}"

  s.dependency "React-Core"
  s.dependency "Flutter"
  s.dependency "FlutterModuleFrameworks-Debug"
  s.dependency "FlutterModuleFrameworks-Release"
end
