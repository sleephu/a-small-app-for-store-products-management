//
//  Item.h
//  HW9T
//
//  Created by sleephu on 3/26/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * descrip;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) Department *department;
@property (nonatomic, retain) UIImage *image;

@end
