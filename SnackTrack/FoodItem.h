//
//  FoodItem.h
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *upcCode;
@property (nonatomic, copy) NSString *expiryDate;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *avgUseTime;
@property (nonatomic, copy) NSMutableDictionary *DBattributes;
@property (nonatomic) int quantity;

-(id)initWithUPC:(NSString *)inUPC errorCode:(int *)errorCode;

-(BOOL)isEqualToFoodItem:(FoodItem *)otherItem;

//compares Two FoodItem Objects
- (NSComparisonResult)compareTo:(FoodItem *)otherItem;

@end
