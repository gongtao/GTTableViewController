Pod::Spec.new do |s|

  s.name         = "GTTableViewController"
  s.version      = "1.0.0"
  s.summary      = "CoreData Display in UITableView."
  s.homepage     = "https://github.com/gongtao/GTTableViewController"
  s.license      = { :type => 'MIT', :file => 'FILE_LICENSE' }
  s.author       = { "gongtao" => "email@address.com" }
  s.platform     = :ios, '5.0'

  s.source       = { :git => "https://github.com/gongtao/GTTableViewController.git", :commit => "b5dc6592da7147fdf4c7fe1a3c84dede80cee624" }

  s.source_files  = 'Class/*.{h,m}'

  s.framework  = 'CoreData'

  s.requires_arc = true

end
