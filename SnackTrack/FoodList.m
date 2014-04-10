//
//  FoodList.m
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "FoodList.h"
#import "FoodItem.h"

@implementation FoodList

@synthesize foodArray;

-(id)init
{
    if (self = [super init])
    {
        foodArray = [NSMutableArray array];
    }
    return self;
}

-(void)addFoodItem:(FoodItem *)item
{
    [foodArray addObject:item];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:foodArray forKey:@"foodArray"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.foodArray = [[aDecoder decodeObjectForKey:@"foodArray"] mutableCopy];
    }
    return self;
}

@end
