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
        [foodArray sortUsingSelector:@selector(compareTo:)];
    }
    return self;
}

-(void)addFoodItem:(FoodItem *)item
{
    int index = [self searchForFoodItem:item];
    
    if (index != -1)
    {
        FoodItem *currentItem = [self.foodArray objectAtIndex:index];
        currentItem.quantity++;
    }
    else
    {
        item.quantity = 1;
        [foodArray addObject:item];
    }
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

-(int)searchForFoodItem:(FoodItem *)item
{
    //Linear search
    for (int index = 0; index < self.foodArray.count; index++)
    {
        FoodItem *currentItem = [foodArray objectAtIndex:index];
        
        if ([item isEqualToFoodItem:currentItem])
            return index;
    }
    
    //If this line is reached, the item was not found
    return -1;
}

-(void)removeFoodItemAtIndex:(int)index
{
    FoodItem *removalItem = [self.foodArray objectAtIndex:index];
    
    if (removalItem.quantity > 1)
        removalItem.quantity--;
    else
        [self.foodArray removeObjectAtIndex:index];
}

-(BOOL)removeFoodItemWithUPC:(NSString *)upcCode
{
    FoodItem *removalItem = [[FoodItem alloc] init];
    removalItem.upcCode = upcCode;
    
    int removalIndex = [self searchForFoodItem:removalItem];
    
    if (removalIndex != -1)
    {
        [self removeFoodItemAtIndex:removalIndex];
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)removeObjectAtIndex:(NSInteger *)index {
    
}

@end
