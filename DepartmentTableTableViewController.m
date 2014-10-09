//
//  DepartmentTableTableViewController.m
//  HW9T
//
//  Created by sleephu on 3/25/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import "DepartmentTableTableViewController.h"
#import "AppDelegate.h"
#import "AddDepartmentViewController.h"
#import "myTableController.h"
@interface DepartmentTableTableViewController ()

@property(nonatomic,strong)NSManagedObjectContext * managedObjectContext;
@property(nonatomic,strong)NSFetchedResultsController* fetchedReusltController;


@end

@implementation DepartmentTableTableViewController

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier]isEqualToString:@"addDepartment"]) {
        UINavigationController * navigationController = segue.destinationViewController;
        AddDepartmentViewController * addDepartmentController = (AddDepartmentViewController *)navigationController.topViewController;
        Department * addDepartment  = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:[self managedObjectContext]];
        addDepartmentController.addDepartment = addDepartment;
    }
    if ([[segue identifier]isEqualToString:@"toItem"]) {
        myTableController * itemViewController = [segue destinationViewController];
        
        NSIndexPath * indexPath =[self.tableView indexPathForSelectedRow];
        
        Department * selectedDepartment =(Department *)[self.fetchedReusltController objectAtIndexPath:indexPath];
        itemViewController.selectedDepartment = selectedDepartment;
        
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError * error = nil;
    if (![[self fetchedReusltController]performFetch:&error]) {
        NSLog(@"Error! %@",error);
        abort();
    }
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
    return [[self.fetchedReusltController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id<NSFetchedResultsSectionInfo>sectionInfo=[[self.fetchedReusltController sections]objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Department * department = [self.fetchedReusltController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",department.name];
    cell.detailTextLabel.text= [NSString stringWithFormat:@"description:%@",department.des];
    return cell;
}


#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{


}

#pragma mark - Fetched Results Controller Section
-(NSFetchedResultsController*)fetchedReusltController{
    if (_fetchedReusltController !=nil) {
        return _fetchedReusltController;
    }
    NSFetchRequest * fetchRequest =[[NSFetchRequest alloc]init];
    
    NSManagedObjectContext * context =[self managedObjectContext];
    
    NSEntityDescription * entity =[NSEntityDescription entityForName:@"Department" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES ];
    //temporary array to hold objects
    NSArray * sortDescriptors =[[NSArray alloc]initWithObjects:sortDescriptor, nil];
    
    fetchRequest.sortDescriptors = sortDescriptors;
    
    _fetchedReusltController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedReusltController.delegate = self;
    
    return _fetchedReusltController;
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
            Department * changeDepartment = [self.fetchedReusltController objectAtIndexPath:indexPath];
            UITableViewCell * cell =[tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = changeDepartment.name;
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
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObjectContext * context =[self managedObjectContext];
        
        Department * departmentToDelete =[self.fetchedReusltController objectAtIndexPath:indexPath];
        [context deleteObject:departmentToDelete];
        
        NSError * error = nil;
        
        if (![context save:&error]) {
            NSLog(@"error! %@",error);
        }
    }

}


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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
