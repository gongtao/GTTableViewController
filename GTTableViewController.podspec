Pod::Spec.new do |s|

  s.name         = "GTTableViewController"
  s.version      = "1.0.0"
  s.summary      = ""

  s.homepage     = "https://github.com/gongtao/GTTableViewController"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "gongtao" => "email@address.com" }
  
  s.platform     = :ios, '5.0'

  s.source       = { :git => "https://github.com/gongtao/GTTableViewController.git", :commit => "67a48f0d3897e9a4d2f45f8b8471d0f81640832b" }

  s.source_files  = 'Class/*.{h,m}'

  s.framework  = 'CoreData'

end
