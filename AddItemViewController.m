//
//  AddItemViewController.m
//  HW9T
//
//  Created by sleephu on 3/25/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@property(nonatomic,strong)UIImagePickerController * imagePicker;

@end

@implementation AddItemViewController
@synthesize addItem,itemsDepartment;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIImagePickerController *)imagePicker{

    if (_imagePicker ==nil) {
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.delegate=self;
    }
    return _imagePicker;

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

- (IBAction)didTapPhoto:(UITapGestureRecognizer *)sender {
    NSLog(@"User Tapped Photo");
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"No Camera Detected");
        
        //return;
        
    }
    
    UIActionSheet * actionSheet =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"User Photo Library", nil];
    
    [actionSheet showInView:self.view];
}

-(void) pickPhotoFromLibrary{

    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
    
}
-(void) takePhotoWithCamera{
    
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{

    if (buttonIndex==actionSheet.cancelButtonIndex) {
        return;
    }
    
    switch (buttonIndex) {
        case 0:
            [self takePhotoWithCamera];
            break;
            case 1:
            [self pickPhotoFromLibrary];
        defasult:
            break;
    }

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image =info[UIImagePickerControllerOriginalImage];
    self.imageView.image=image;
    addItem.image = image;

}
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [super cancel];
}

- (IBAction)save:(UIBarButtonItem *)sender {

    addItem.department = itemsDepartment;
    
    addItem.name = _itemName.text;
    addItem.descrip=_itemDes.text;
    NSNumberFormatter * f =[[NSNumberFormatter alloc]init];
    addItem.quantity= [f numberFromString:_itemQuantity.text ];
    addItem.price=[f numberFromString:_itemPrice.text];
    addItem.image =self.imageView.image;
    [super save];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //print text
    
    if ([textField tag ]==0) {
        NSString * input = [textField text];
        if ([input isEqualToString:@""]) {
            NSString *msg = [NSString stringWithFormat:@"Item name cannot be %@. Please enter again",[textField text]];
            UIAlertView * nAlert =[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [nAlert show];
            
        }
        else{
            [_itemDes resignFirstResponder];
            
        }
        
    }
    else if ([textField tag ]==1) {
        NSString * input = [textField text];
        if ([input isEqualToString:@""]) {
            NSString *msg = [NSString stringWithFormat:@"Item name cannot be %@. Please enter again",[textField text]];
            UIAlertView * nAlert =[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [nAlert show];
            
        }
        else{
            
            [_itemQuantity resignFirstResponder];
        }
        
        
    }
    else if ([textField tag ]==2) {
        NSString * input = [textField text];
        int q = [input intValue];
        if (q ==0) {
            NSString *msg = [NSString stringWithFormat:@"You typed : %@,quantity must be integer!Please enter again",[textField text]];
            UIAlertView * intAlert =[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [intAlert show];
        }
        else{
            
            [_itemPrice becomeFirstResponder];
        }
        
    }
    else if ([textField tag ]==3) {
        NSString * input = [textField text];
        NSNumberFormatter * formatter =[[NSNumberFormatter  alloc]init];
        NSNumber * number =[formatter numberFromString:input];
        if (number ==nil) {
            NSString *msg = [NSString stringWithFormat:@"You typed : %@,price must be numeric!Please enter again",[textField text]];
            UIAlertView * nAlert =[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [nAlert show];
        }
    }
    // the user pressed the "Done" button, so dismiss the keyboard
    [textField resignFirstResponder];
    return YES;
}

@end
