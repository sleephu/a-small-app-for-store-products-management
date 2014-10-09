//
//  myTableController.h
//  Using_Storyboard
//
//  Created by rab on 3/23/14.
//  Copyright (c) 2014 rab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "Department.h"
#import "myTableController.h"
@interface myTableController : UITableViewController<NSFetchedResultsControllerDelegate,UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSMutableArray *items;
    NSMutableArray *displayItem;
}
@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,strong) Department * selectedDepartment;
@property(nonatomic,strong) NSMutableArray *displayItem;
@property int num;
@end
