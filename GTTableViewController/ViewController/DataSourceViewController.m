//
//  DataSourceViewController.m
//  GTTableViewController
//
//  Created by 龚涛 on 11/13/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import "DataSourceViewController.h"
#import "Player.h"

@interface DataSourceViewController ()

@end

@implementation DataSourceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"DataSource Test";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"加" style:UIBarButtonItemStyleBordered target:self action:@selector(add)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"减" style:UIBarButtonItemStyleBordered target:self action:@selector(minus)];
    
    _viewController = [[GTTableViewController alloc] init];
    _viewController.dataSource = self;
    [self addChildViewController:_viewController];
    [self.view addSubview:_viewController.view];
    
    if (!IS_IO7) {
        CGRect frame = _viewController.view.bounds;
        frame.origin.y = -20.0;
        frame.size.height -= 44.0;
        _viewController.tableView.frame = frame;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)add
{
    //    int num = [[self.fetchedResultsController.sections objectAtIndex:0] numberOfObjects];
    int num = 0;
    Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:[_viewController managedObjectContext]];
    player.name = [NSString stringWithFormat:@"player%i", num];
    player.age = [NSNumber numberWithInt:num];
    
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [_viewController managedObjectContext];
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)minus
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *playerEntity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:[_viewController managedObjectContext]];
    [fetchRequest setEntity:playerEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", @"player0"];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *results = [[_viewController managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (!error && results.count > 0) {
        Player *player = [results objectAtIndex:0];
        [[_viewController managedObjectContext] deleteObject:player];
        
        NSManagedObjectContext *managedObjectContext = [_viewController managedObjectContext];
        if (managedObjectContext != nil) {
            if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    }
}

#pragma mark - GTTableViewControllerDataSource

- (NSFetchRequest *)fetchRequestGTTableViewController:(GTTableViewController *)viewController
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *playerEntity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:[viewController managedObjectContext]];
    [fetchRequest setEntity:playerEntity];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return fetchRequest;
}

- (NSManagedObjectContext *)managedObjectContextGTTableViewController:(GTTableViewController *)viewController
{
    id appDelegate = [UIApplication sharedApplication].delegate;
    return [appDelegate managedObjectContext];
}

- (void)configCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath viewController:(GTTableViewController *)viewController fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    Player *player = [fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = player.name;
}

- (UITableViewCell *)viewController:(GTTableViewController *)viewController cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [viewController.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configCell:cell cellForRowAtIndexPath:indexPath viewController:viewController fetchedResultsController:fetchedResultsController];
    
    return cell;
}

@end
