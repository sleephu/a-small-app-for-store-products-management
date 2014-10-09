//
//  AddItemViewController.h
//  HW9T
//
//  Created by sleephu on 3/25/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"
#import "Department.h"
#import "Item.h"
#import "myTableController.h"
@interface AddItemViewController : CoreViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)Department * itemsDepartment;
@property(nonatomic,strong)Item * addItem;

@property (strong, nonatomic) IBOutlet UITextField *itemName;
@property (strong, nonatomic) IBOutlet UITextField *itemDes;
@property (strong, nonatomic) IBOutlet UITextField *itemQuantity;
@property (strong, nonatomic) IBOutlet UITextField *itemPrice;

@property (strong, nonatomic) IBOutlet UIView *ContainerView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)didTapPhoto:(UITapGestureRecognizer *)sender;

- (IBAction)cancel:(UIBarButtonItem *)sender;

- (IBAction)save:(UIBarButtonItem *)sender;

@end
