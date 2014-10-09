//
//  EditItemViewController.m
//  HW9T
//
//  Created by sleephu on 3/27/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import "EditItemViewController.h"
#import "Item.h"
@interface EditItemViewController ()
//@property(nonatomic,strong)Item * editItem;
//@property(nonatomic,strong)UIImagePickerController * imagePicker;
@end

@implementation EditItemViewController
@synthesize editItem;
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
    _name.enabled = NO;
    _des.enabled = NO;
    _quantity.enabled =NO;
    _price.enabled =NO;
    
    
    _name.borderStyle = UITextBorderStyleNone;
    _des.borderStyle = UITextBorderStyleNone;
    _quantity.borderStyle = UITextBorderStyleNone;
    _price.borderStyle = UITextBorderStyleNone;
    
    _name.text = editItem.name;
    _des.text =editItem.descrip;
    _quantity.text = [NSString stringWithFormat:@"%@", editItem.quantity];
    _price.text =[NSString stringWithFormat:@"%@", editItem.price];
    _imageField.image = editItem.image;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [super cancel];
}

- (IBAction)onAddClicked:(UIBarButtonItem *)sender {
//    NSLog(@"-----addButtonTitle %@",_addImageButton.title);
    if ([_addImageButton.title isEqualToString:@"Edit"]) {
        
        [self setTitle:@"Edit Item"];
        _name.enabled = YES;
        _des.enabled = YES;
        _quantity.enabled =YES;
        _price.enabled = YES;
        
        //        swipeGestureRecognizer.enabled = NO;
        _name.borderStyle = UITextBorderStyleRoundedRect;
        _des.borderStyle = UITextBorderStyleRoundedRect;
        _quantity.borderStyle = UITextBorderStyleRoundedRect;
        _price.borderStyle = UITextBorderStyleRoundedRect;
        
        
        _addImageButton.title =@"Save";
    }else if ([_addImageButton.title isEqualToString:@"Save"]){
        
        [super save];
        _addImageButton.title=@"Edit";
        
        _name.enabled = NO;
        _des.enabled = NO;
        _quantity.enabled =NO;
        _price.enabled =NO;
        
        _name.borderStyle = UITextBorderStyleNone;
        _des.borderStyle = UITextBorderStyleNone;
        _quantity.borderStyle = UITextBorderStyleNone;
        _price.borderStyle = UITextBorderStyleNone;
        
        editItem.name = _name.text;
        editItem.descrip =_des.text;
        NSNumberFormatter * f =[[NSNumberFormatter alloc]init];
        editItem.quantity= [f numberFromString:_quantity.text ];
        editItem.price=[f numberFromString:_price.text];
        
        editItem.image = self.imageField.image;
        //        item.image = self.imageField.image
        //        NSData *dataImage= UIImageJPEGRepresentation(self.imageField.image , 0.0);
        //        selectedItem.image = dataImage;
    }
    

}
//-(NSManagedObjectContext *)managedObjectContext{
//
//    return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
//}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion: nil];
    
    self.imageField.image =[info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    // Convert image to Data for entry into Core Data
    //    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(self.imageField.image)];
    
    // Add image to Core Data
    editItem.image = self.imageField.image;
    
    
    //    NSData *dataImage= UIImageJPEGRepresentation(self.imageField.image , 0.0);
    //    item.image = dataImage;
    //    item.imageData = (NSData*)self.imageField.image;
    
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
    if ([_addImageButton.title isEqualToString:@"Save"]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType =
        UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        /*UIImagePickerControllerSourceTypePhotoLibrary*/
        
        [self presentViewController:picker animated:YES completion:nil];
    }
   

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
            [_des resignFirstResponder];
            
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
            
            [_quantity resignFirstResponder];
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
            
            [_price becomeFirstResponder];
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
