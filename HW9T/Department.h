//
//  Department.h
//  HW9T
//
//  Created by sleephu on 3/25/14.
//  Copyright (c) 2014 Jingyun Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Department : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * des;
@property (nonatomic, retain) NSSet *items;
@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
