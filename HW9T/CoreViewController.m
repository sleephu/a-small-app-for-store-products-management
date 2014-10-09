//
//  CoreViewController.m
//  HW9T
//
//  Created by sleephu on 3/24/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import "CoreViewController.h"
#import "AppDelegate.h"
@interface CoreViewController ()

@property(nonatomic,strong)NSManagedObjectContext * manageObjectContext;
@end

@implementation CoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSManagedObjectContext *)manageObjectContext{

    return [(AppDelegate *)[[UIApplication sharedApplication]delegate] managedObjectContext];
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
-(void) cancel{
    
    [self.manageObjectContext rollback];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save{
    
    NSError * error= nil;
    if ([self.manageObjectContext hasChanges]) {
        if (![self.manageObjectContext save:&error]) {
             NSLog(@"Save Failed: %@",[error localizedDescription]);
        } else {
                NSLog(@"Save Succeeded");
        }
       
    }
[self dismissViewControllerAnimated:YES completion:nil];
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

@end
