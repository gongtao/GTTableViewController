//
//  DataSourceViewController.h
//  GTTableViewController
//
//  Created by 龚涛 on 11/13/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import "GTTableViewController.h"

@interface DataSourceViewController : UIViewController <GTTableViewControllerDataSource>
{
    GTTableViewController *_viewController;
}

@end
