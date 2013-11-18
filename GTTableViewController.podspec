Pod::Spec.new do |s|

  s.name         = "GTTableViewController"
  s.version      = "1.0"
  s.summary      = "CoreData Display in UITableView."

  s.homepage     = "https://github.com/gongtao/GTTableViewController"

  s.license      = 'MIT'

  s.author       = { "gongtao" => "gongtao@jike.com" }

  s.platform     = :ios, '5.0'

  s.source       = { :git => "https://github.com/gongtao/GTTableViewController.git", :tag => "1.0" }

  s.source_files  = 'Class/*.{h,m}'

  s.framework  = 'UIKit'

  s.requires_arc = true

end
