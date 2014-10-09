//
//  AddDepartmentViewController.m
//  HW9T
//
//  Created by sleephu on 3/25/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import "AddDepartmentViewController.h"

@interface AddDepartmentViewController ()

@end

@implementation AddDepartmentViewController
@synthesize addDepartment;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [super cancel];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    
    addDepartment.name =_departmentName.text;
    addDepartment.des = _departmentDes.text;
    
    [super save];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //print text
    
    if ([textField tag ]==4) {
        NSString * input = [textField text];
        if ([input isEqualToString:@""]) {
            NSString *msg = [NSString stringWithFormat:@"Department name cannot be %@. Please enter again",[textField text]];
            UIAlertView * nAlert =[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [nAlert show];
            
        }
        else{
            [_departmentDes resignFirstResponder];
            
        }
        
    }


    else if ([textField tag ]==5) {
        NSString * input = [textField text];
        if ([input isEqualToString:@""]) {
            NSString *msg = [NSString stringWithFormat:@"Department name cannot be %@. Please enter again",[textField text]];
            UIAlertView * nAlert =[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [nAlert show];
            
        }

   
    }
    // the user pressed the "Done" button, so dismiss the keyboard
    [textField resignFirstResponder];
    return YES;
}

@end
