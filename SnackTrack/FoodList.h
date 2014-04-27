//
//  FoodList.h
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FoodItem;

@interface FoodList : NSObject <NSCoding>

//Array that will store the food items.
@property (nonatomic, strong) NSMutableArray *foodArray;

//adds a food item
-(void)addFoodItem:(FoodItem *)item;

//Returns index in the foodArray of the parameter food item if found - returns -1 if it is not found
-(int)searchForFoodItem:(FoodItem *)item;

//removes an item at a specific index.
-(void)removeFoodItemAtIndex:(int)index;

//Returns YES if the food item was found and removed, returns NO if the food item was not found and could not be removed
-(BOOL)removeFoodItemWithUPC:(NSString *)upcCode;
-(void)removeObjectAtIndex:(NSInteger *)index;
//returns YES if correct number could be removed, returns NO if user asked for too many items to be removed
-(BOOL)removeMultipleObjects:(NSInteger *)items :(NSInteger *)index;

@end
