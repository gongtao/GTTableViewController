## GTTableViewController

GTTableViewController is a light weight subclass of `UIViewController` that integrates `NSFetchedResultsController` and `UITableView` to display data of CoreData.
It has a good scalability, and can be integrated to your project either by inheritance or as a child viewController using datasource methods.
To display the data in UITableView, all you need to do is to customize your own `NSFetchRequest` and `UITableViewCell` objects.

## How to get started?

- [Download GTTableViewController](https://github.com/gongtao/GTTableViewController/archive/master.zip) and add files under the Class folder into your project.
- There are two ways to use:  inheritance and GTTableViewControllerDataSource.

### Inheritance

Write a GTTableViewController subclass and override its methods like this:

#### NSManagedObjectContext

Return `NSManagedObjectContext` object which CoreData context you want to use. Default returns from AppDelegate, If you do not override it.

```objective-c
- (NSManagedObjectContext *)managedObjectContext
{
    id appDelegate = [UIApplication sharedApplication].delegate;
    return [appDelegate managedObjectContext];
}
```

#### NSFetchRequest

Retrun `NSFetchRequest` object include the fetch rules and orders. This method must be overrided.

```objective-c
- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *playerEntity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:playerEntity];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return fetchRequest;
}
```

#### UITableViewCell Display

Config your own `UITableViewCell`. Cell is empty, if you do not override it.

```objective-c
- (void)configCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    Player *player = [fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = player.name;
}
```

#### UITableViewCell

Return your own `UITableViewCell`. Cell is `UITableViewCellStyleDefault`, if you do not override it.

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configCell:cell cellForRowAtIndexPath:indexPath fetchedResultsController:fetchedResultsController];
    
    return cell;
}
```

### GTTableViewControllerDataSource

DataSource is almost like Inheritance way. This way is used for integrating it as a subview or a child viewController.

#### Init

In `UIViewController` object, write code like: 

```objective-c
GTTableViewController *viewController = [[GTTableViewController alloc] init];
viewController.dataSource = self;
[self addChildViewController:viewController];
[self.view addSubview:viewController.view];
```

#### NSManagedObjectContext

```objective-c
- (NSManagedObjectContext *)managedObjectContextGTTableViewController:(GTTableViewController *)viewController
```

#### NSFetchRequest

This method is requeired.

```objective-c
- (NSFetchRequest *)fetchRequestGTTableViewController:(GTTableViewController *)viewController
```

#### UITableViewCell Display

```objective-c
- (void)configCell:(UITableViewCell *)cell viewController:(GTTableViewController *)viewController fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
```

#### UITableViewCell

```objective-c
- (void)configCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath viewController:(GTTableViewController *)viewController fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
```

## Other useful infomation

Fetch objects method

```objective-c
- (void)performFetch
```

This property controls the max number of displayed fetched objects in UITableView.

```objective-c
@property (nonatomic, assign) int numberOfFetchLimit
```

## Contact

龚涛    Gong Tao    mail: gongtaoatbupt@gmail.com


