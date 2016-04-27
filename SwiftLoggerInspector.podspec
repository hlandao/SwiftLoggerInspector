Pod::Spec.new do |s|
  s.name         = "SwiftLoggerInspector"
  s.version      = "0.0.3"
  s.summary      = "On screen logs inspector for XCGLogger"
  s.description  = <<-DESC
                   A XCGLogger destination that lets you present to the logs on the screen of the running device
                   DESC
  s.platforms	   = { :ios => "8.0" }
  s.homepage     = "https://github.com/hlandao/SwiftLoggerInspector"
  s.license      = "MIT"
  s.author       = { "Hadar Landao" => "hlandao@gmail.com" }
  s.source       = { :git => "https://github.com/hlandao/SwiftLoggerInspector.git", :tag => "0.0.3" }
  s.source_files = "SwiftLoggerInspector/SwiftLoggerInspector/LoggerInspectorDestination.swift", "SwiftLoggerInspector/SwiftLoggerInspector/LoggerInspectorViewController.swift", "SwiftLoggerInspector/SwiftLoggerInspector/LogTableViewCell.swift"
  s.dependency "SnapKit", "~> 0.19.1"
  s.dependency "XCGLogger", "~> 3.3"

  s.framework  = "Foundation"
  s.requires_arc = true
end
