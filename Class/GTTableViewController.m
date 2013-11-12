//
//  GTTableViewController.m
//  GTTableViewController
//
//  Created by 龚涛 on 11/11/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import "GTTableViewController.h"

@interface GTTableViewController (Private)

@end

@implementation GTTableViewController

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
    
    _numberOfFetchLimit = 10;
    
    _rowAnimation = UITableViewRowAnimationFade;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.fetchedResultsController.delegate = nil;
    self.fetchedResultsController = nil;
}

#pragma mark - public method

- (void)performFetch
{
    if (!_fetchedResultsController) {
        [self fetchedResultsController];
        return;
    }
    
    NSError *error = NULL;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Override method

- (NSManagedObjectContext *)managedObjectContext
{
    if ([self.dataSource respondsToSelector:@selector(managedObjectContextGTTableViewController:)]) {
        return [self.dataSource managedObjectContextGTTableViewController:self];
    }
    id appDelegate = [UIApplication sharedApplication].delegate;
    return [appDelegate managedObjectContext];
}

- (NSFetchRequest *)fetchRequest
{
    return [self.dataSource fetchRequestGTTableViewController:self];
}

- (NSString *)sectionNameKeyPath
{
    return [self.dataSource sectionNameKeyPathGTTableViewController:self];
}

- (void)configCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    if ([self.dataSource respondsToSelector:@selector(configCell:viewController:fetchedResultsController:)]) {
        [self.dataSource configCell:cell viewController:self fetchedResultsController:fetchedResultsController];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    if ([self.dataSource respondsToSelector:@selector(viewController:cellForRowAtIndexPath:fetchedResultsController:)]) {
        UITableViewCell *cell = [self.dataSource viewController:self cellForRowAtIndexPath:indexPath fetchedResultsController:fetchedResultsController];
        [self configCell:cell cellForRowAtIndexPath:indexPath fetchedResultsController:fetchedResultsController];
        return cell;
    }
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configCell:cell cellForRowAtIndexPath:indexPath fetchedResultsController:fetchedResultsController];
    
    return cell;
}

#pragma mark - Property method

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[self fetchRequest] managedObjectContext:[self managedObjectContext] sectionNameKeyPath:[self sectionNameKeyPath] cacheName:@"DataCache"];
    _fetchedResultsController.delegate = self;
    
    [self performFetch];
    
    return _fetchedResultsController;
}

- (void)setNumberOfFetchLimit:(int)numberOfFetchLimit
{
    if (_numberOfFetchLimit != numberOfFetchLimit) {
        if (numberOfFetchLimit < 0) {
            numberOfFetchLimit = 0;
        }
        _numberOfFetchLimit = numberOfFetchLimit;
        [self.tableView reloadData];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [_tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    int number = [[[controller sections] objectAtIndex:[indexPath section]] numberOfObjects];
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            if (_numberOfFetchLimit <= number) {
                if ([newIndexPath row] < _numberOfFetchLimit - 1) {
                    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:_rowAnimation];
                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_numberOfFetchLimit-1 inSection:[newIndexPath section]]] withRowAnimation:_rowAnimation];
                }
                else if ([newIndexPath row] + 1 == _numberOfFetchLimit) {
                    [self configCell:[self.tableView cellForRowAtIndexPath:newIndexPath] cellForRowAtIndexPath:newIndexPath fetchedResultsController:self.fetchedResultsController];
                }
            }
            else {
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:_rowAnimation];
            }
            break;
            
        case NSFetchedResultsChangeDelete:
            if (_numberOfFetchLimit <= number) {
                if ([newIndexPath row] < _numberOfFetchLimit - 1) {
                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:_rowAnimation];
                    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_numberOfFetchLimit-1 inSection:[indexPath section]]] withRowAnimation:_rowAnimation];
                }
                else if ([newIndexPath row] + 1 == _numberOfFetchLimit) {
                    [self configCell:[self.tableView cellForRowAtIndexPath:indexPath] cellForRowAtIndexPath:indexPath fetchedResultsController:self.fetchedResultsController];
                }
            }
            else {
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:_rowAnimation];
            }
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configCell:[self.tableView cellForRowAtIndexPath:indexPath] cellForRowAtIndexPath:indexPath fetchedResultsController:self.fetchedResultsController];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray
                                                    arrayWithObject:indexPath] withRowAnimation:_rowAnimation];
            [self.tableView insertRowsAtIndexPaths:[NSArray
                                                    arrayWithObject:newIndexPath] withRowAnimation:_rowAnimation];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:_rowAnimation];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:_rowAnimation];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [_tableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger number = [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
    if (number > _numberOfFetchLimit) {
        number = _numberOfFetchLimit;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView cellForRowAtIndexPath:indexPath fetchedResultsController:self.fetchedResultsController];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end
