//
//  GTTableViewController.h
//  GTTableViewController
//
//  Created by 龚涛 on 11/11/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GTTableViewControllerDelegate;

@interface GTTableViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, assign) id<GTTableViewControllerDelegate> delegate;

/* The context that GTTableViewController uses.
 Overrides this function to make GTTableViewController use your own NSManagedObjectContext object.
 */
- (NSManagedObjectContext *)managedObjectContext;

/* The fetchRequest that GTTableViewController uses.
 Overrides this function to make GTTableViewController use your own NSFetchRequest object.
 */
- (NSFetchRequest *)fetchRequest;

/* Returns cells that GTTableViewController uses.
 Overrides this function to make GTTableViewController use your own cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

@end

@protocol GTTableViewControllerDelegate <NSObject>

@required

- (NSFetchRequest *)fetchRequestGTTableViewController:(GTTableViewController *)viewController;

@optional

- (NSManagedObjectContext *)managedObjectContextGTTableViewController:(GTTableViewController *)viewController;

- (UITableViewCell *)viewController:(GTTableViewController *)viewController cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

@end
