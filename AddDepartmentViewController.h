//
//  AddDepartmentViewController.h
//  HW9T
//
//  Created by sleephu on 3/25/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"
#import "Department.h"
@interface AddDepartmentViewController :CoreViewController<UITextFieldDelegate>

@property(nonatomic, strong)Department * addDepartment;
@property (strong, nonatomic) IBOutlet UITextField *departmentName;

@property (strong, nonatomic) IBOutlet UITextField *departmentDes;

- (IBAction)cancel:(UIBarButtonItem *)sender;

- (IBAction)save:(UIBarButtonItem *)sender;

@end
