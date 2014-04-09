//
//  FoodList.h
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FoodItem;

@interface FoodList : NSObject

@property (nonatomic, strong) NSMutableArray *foodArray;

-(void)addFoodItem:(FoodItem *)item;

@end
