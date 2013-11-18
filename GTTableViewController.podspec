Pod::Spec.new do |s|

  s.name         = "GTTableViewController"
  s.version      = "1.0.0"
  s.summary      = ""

  s.homepage     = "https://github.com/gongtao/GTTableViewController"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "gongtao" => "email@address.com" }
  
  s.platform     = :ios, '5.0'

  s.source       = { :git => "https://github.com/gongtao/GTTableViewController.git", :commit => "ba42bfa1d696f961e365a3ecea4265bff355fc5d" }

  s.source_files  = 'Class/*.{h,m}'

  s.framework  = 'CoreData', 'UIKit'

end