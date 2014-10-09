//
//  EditItemViewController.h
//  HW9T
//
//  Created by sleephu on 3/27/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "CoreViewController.h"
@interface EditItemViewController :CoreViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,NSFetchedResultsControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageField;
@property(strong,nonatomic) Item * editItem;

- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)onAddClicked:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *des;
@property (strong, nonatomic) IBOutlet UITextField *quantity;
@property (strong, nonatomic) IBOutlet UITextField *price;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addImageButton;
- (IBAction)didTapPhoto:(UITapGestureRecognizer *)sender;

@end
