//
//  GTTableViewController.h
//  GTTableViewController
//
//  Created by 龚涛 on 11/11/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol GTTableViewControllerDataSource;

@interface GTTableViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

/* The max allowed number of displayed objects.
 Change its value to add or reduce the displayed objects.
 */
@property (nonatomic, assign) NSUInteger numberOfFetchLimit;

@property (nonatomic, assign) UITableViewRowAnimation rowAnimation;

@property (nonatomic, assign) id<GTTableViewControllerDataSource> dataSource;

/* Write your code in block function to change request that GTTableViewController uses.
 When the request is changed, the presentation of data may be also changed.
 */
- (void)changeFetchRequest:(void (^)(NSFetchRequest *request))block;

- (void)performFetch;

/* The cache name that NSFetchedResultsController uses.
 Overrides this function to make GTTableViewController use your own cache name.
 */
- (NSString *)cacheName;

/* The context that GTTableViewController uses.
 Overrides this function to make GTTableViewController use your own NSManagedObjectContext object.
 */
- (NSManagedObjectContext *)managedObjectContext;

/* The fetchRequest that GTTableViewController uses.
 Overrides this function to make GTTableViewController use your own NSFetchRequest object.
 */
- (NSFetchRequest *)fetchRequest;

/* The sectionNameKeyPath that GTTableViewController uses.
 Overrides this function to make GTTableViewController group objects by your own way.
 */
- (NSString *)sectionNameKeyPath;

/* Config UITableView cells.
 Overrides this function to change cell's data.
 */
- (void)configCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

/* Returns cells that GTTableViewController uses.
 Overrides this function to make GTTableViewController use your own cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

@end


@protocol GTTableViewControllerDataSource <NSObject>

@required

- (NSFetchRequest *)fetchRequestGTTableViewController:(GTTableViewController *)viewController;

@optional

- (NSString *)cacheNameGTTableViewController:(GTTableViewController *)viewController;

- (NSString *)sectionNameKeyPathGTTableViewController:(GTTableViewController *)viewController;

- (NSManagedObjectContext *)managedObjectContextGTTableViewController:(GTTableViewController *)viewController;

- (void)configCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath viewController:(GTTableViewController *)viewController fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

- (UITableViewCell *)viewController:(GTTableViewController *)viewController cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

@end
