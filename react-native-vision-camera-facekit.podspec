require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-vision-camera-facekit"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = { "Cristofer Feliz" => package["author"] }

  s.platform     = :ios, "12.4"
  s.source       = {
    :git  => "https://github.com/cristofer03/react-native-vision-camera-facekit.git",
    :tag  => "#{s.version}"
  }

  s.source_files = "ios/**/*.{h,m,mm,swift}"
  s.public_header_files = "ios/**/*.h"
  
  s.frameworks    = "Foundation", "UIKit", "CoreMedia", "CoreVideo", "Vision"
  s.vendored_frameworks = "ios/AppleVision.framework"

  s.dependency "React-Core"
  s.dependency "VisionCamera"
end
