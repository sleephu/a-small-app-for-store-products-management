//
//  myTableController.m
//  Using_Storyboard
//
//  Created by rab on 3/23/14.
//  Copyright (c) 2014 rab. All rights reserved.
//

#import "myTableController.h"
#import "AppDelegate.h"
#import "AddItemViewController.h"

#import "EditItemViewController.h"
@interface myTableController ()

@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;

@property(nonatomic,strong)NSFetchedResultsController*fetchedResultsController;


@end

@implementation myTableController
@synthesize items,displayItem;
@synthesize selectedDepartment;
@synthesize num;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSManagedObjectContext *)managedObjectContext{
    
    return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender{
    if ([segue.identifier isEqualToString:@"addItem"]) {
        UINavigationController * navigationController=[segue destinationViewController];
        
        AddItemViewController * addItemViewController = (AddItemViewController*)navigationController.topViewController;
        
        Item * addItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[self managedObjectContext]];
        
        addItemViewController.itemsDepartment = self.selectedDepartment;
        addItemViewController.addItem=addItem;
   
    }
    if ([segue.identifier isEqualToString:@"addImage"]) {
        
        UINavigationController * navigationController = segue.destinationViewController;
        
        EditItemViewController * detailViewController =(EditItemViewController*)navigationController.topViewController;
       
        NSIndexPath * indexPath =[self.tableView indexPathForCell:sender];
        Item * editItem = (Item *)[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        detailViewController.editItem = editItem;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    num=0;
    self.displayItem = [NSMutableArray arrayWithCapacity:[[self.fetchedResultsController fetchedObjects] count]];
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    items =[[NSMutableArray alloc]init];
//     items = [@[@"green animal",@"herp",@"lufei"] mutableCopy];

    NSError * error = nil;
    if (![[self fetchedReusltController]performFetch:&error]) {
        NSLog(@"Error! %@",error);
        abort();
    }
}
- (void)viewDidUnload
{
	self.displayItem = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        // normal table view population
        
        return displayItem.count;

    }else
    {
        // search view population
        
        id<NSFetchedResultsSectionInfo>sectionInfo=[[self.fetchedReusltController sections]objectAtIndex:section];
        return[sectionInfo numberOfObjects];
            }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    
    // Configure the cell...
//    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"p%ld.jpg", (long)indexPath.row]];
//    cell.textLabel.text = items[indexPath.row];
//    cell.detailTextLabel.text=@"";
    if (tableView == self.tableView) {
        Item * item =[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        cell.textLabel.text = item.name;
        cell.detailTextLabel.text =[NSString stringWithFormat:@"description: %@; Quantity: %@; Price: %@ ",item.descrip,item.quantity,item.price];
        // NSData *dataImage= UIImageJPEGRepresentation(self.imageField.image , 0.0);
        
//        UIImage *
//        image = [UIImage imageWithData:item.image];
        cell.imageView.image=item.image;
        //    = (UIImage*)item.imageData;

    }
    
    if(tableView == self.searchDisplayController.searchResultsTableView){
        // search view population
        //            cell.textLabel.text=[displayItem objectAtIndex:indexPath.row];
        //           NSLog(@"%@",indexPath);
        //           NSLog(@"%@",displayItem);
        Item * item;
        
        item =displayItem[num++];
        
        cell.textLabel.text =[NSString stringWithFormat:@"%@",item.name];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"description: %@; Quantity: %@; Price: %@ ",item.descrip,item.quantity,item.price];
        
        
    }
    return cell;
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //[self.filteredData removeAllObjects];
    // First clear the filtered array.
    [self.displayItem removeAllObjects];
//    NSLog(@"--------displayItem",displayItem);
    //
    //    NSString * name =searchText ;
    //
    //    Item * obj;
    //    for (Item * item in items) {
    //        if ([[item valueForKey:@"name"] isEqualToString:name ]) {
    //            obj=item;
    //            break;
    //        }
    //    }
    for (Item *item in [self.fetchedResultsController fetchedObjects])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"(SELF contains[cd] %@)", searchText];
        [item.name compare:searchText options:NSCaseInsensitiveSearch];
        //        BOOL resultID = [predicate evaluateWithObject:product.productID];
        BOOL resultName = [predicate evaluateWithObject:item.name];
        //        if([scope isEqualToString:@&quot;Product ID&quot;] && resultID)
        //        {
        //            [self.filteredData addObject:product];
        //        }
//                NSLog(@"Scope %@",item.name);
        //        NSLog(@"Result %hhd ",resultName);
//               NSLog(@"Search Text %@",searchText);
        if(
           //           [scope isEqualToString:] &&
           resultName)
        {
            //            NSLog(@"item %@", item);
            [ self.displayItem addObject:item];
                      NSLog(@"displayItem %@",self.displayItem);
        }
        //        if([scope isEqualToString:@"Any"] && (resultID || resultName))
        //        {
        //            [self.filteredData addObject:product];
        //        }
    }
    num=0;
}


#pragma mark - Fetched Results Controller Section
-(NSFetchedResultsController*)fetchedReusltController{
    if (_fetchedResultsController !=nil) {
        return _fetchedResultsController;
    }
    NSFetchRequest * fetchRequest =[[NSFetchRequest alloc]init];
    
    NSManagedObjectContext * context =[self managedObjectContext];
    
    NSEntityDescription * entity =[NSEntityDescription entityForName:@"Item" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    

    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES ];
    
    NSPredicate * predicate =[NSPredicate predicateWithFormat:@"department=%@",selectedDepartment];
    [fetchRequest setPredicate:predicate];
    
    //temporary array to hold objects
    NSArray * sortDescriptors =[[NSArray alloc]initWithObjects:sortDescriptor, nil];
    
    fetchRequest.sortDescriptors = sortDescriptors;
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark - Fetched Results Controller Delegates
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView beginUpdates];
    
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView endUpdates];
    
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    UITableView * tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:{
            Item * changeItem = [self.fetchedReusltController objectAtIndexPath:indexPath];
            UITableViewCell * cell =[tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = changeItem.name;
        }
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
    }
    
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    
    switch (type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case  NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [self.items removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObjectContext * context =[self managedObjectContext];
        
        Item * itemToDelete =[self.fetchedReusltController objectAtIndexPath:indexPath];
        [context deleteObject:itemToDelete];
        
        NSError * error = nil;
        
        if (![context save:&error]) {
            NSLog(@"error! %@",error);
        }
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    if([segue.identifier isEqualToString:@"Details"]) {
//        UIViewController *tovc = segue.destinationViewController;
//        UIImageView *imageView = (UIImageView*)[tovc.view viewWithTag:1];
//        if(imageView){
//            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"p%d.jpg",self.tableView.indexPathForSelectedRow.row]];
//        }
//        tovc.title = [items objectAtIndex:self.tableView.indexPathForSelectedRow.row];
//    }
//    
//}


- (IBAction)done:(UIStoryboardSegue *)segue {
    // Optional place to read data from closing controller
}



@end
