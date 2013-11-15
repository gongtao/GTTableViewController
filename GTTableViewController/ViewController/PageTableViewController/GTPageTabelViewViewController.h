//
//  GTPageTabelViewViewController.h
//  GTTableViewController
//
//  Created by 龚涛 on 11/15/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import "GTTableViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface GTPageTabelViewViewController : GTTableViewController <EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@end
