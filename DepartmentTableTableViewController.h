//
//  DepartmentTableTableViewController.h
//  HW9T
//
//  Created by sleephu on 3/25/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"
@interface DepartmentTableTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property(nonatomic,strong)Department * department;
@end
