Pod::Spec.new do |s|

  s.name         = "GTTableViewController"
  s.version      = "1.0.0"
  s.summary      = "CoreData Display in UITableView."
  s.homepage     = "https://github.com/gongtao/GTTableViewController"
  s.license      = { :type => 'MIT', :file => 'FILE_LICENSE' }
  s.author       = { "gongtao" => "email@address.com" }
  s.platform     = :ios, '5.0'

  s.source       = { :git => "https://github.com/gongtao/GTTableViewController.git", :commit => "6cf84e2ef2272037d1c5e34afd6662dedf43e6af" }

  s.source_files  = 'Class/*.{h,m}'

  s.framework  = 'CoreData'

  s.requires_arc = true

end
