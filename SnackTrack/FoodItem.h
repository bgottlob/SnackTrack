//
//  FoodItem.h
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodItem : NSObject <NSCoding>
//Item properties
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *upcCode;
@property (nonatomic, copy) NSDate *expiryDate;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSMutableDictionary *DBattributes;
@property (nonatomic) int quantity;

@property (nonatomic, strong) UIImage *image;

//Constructs a food item from a specific UPC code.
-(id)initWithUPC:(NSString *)inUPC errorCode:(int *)errorCode;

//Checks if two food items are the same
-(BOOL)isEqualToFoodItem:(FoodItem *)otherItem;

//compares Two FoodItem Objects
- (NSComparisonResult)compareTo:(FoodItem *)otherItem;

@end
