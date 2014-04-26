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

//Construct the list
-(id)init
{
    if (self = [super init])
    {
        foodArray = [NSMutableArray array];
        [foodArray sortUsingSelector:@selector(compareTo:)];
    }
    return self;
}
//Add an item
-(void)addFoodItem:(FoodItem *)item
{
	//Search the list for the item
    int index = [self searchForFoodItem:item];
    //if it is found, just increment quantity
    if (index != -1)
    {
        FoodItem *currentItem = [self.foodArray objectAtIndex:index];
        currentItem.quantity++;
    }
	//otherwise put it in the array as a new object.
    else 
    {
        [foodArray addObject:item];
    }
}

// Encode data for storage
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:foodArray forKey:@"foodArray"];
}
// Construct an object from stored data. 
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.foodArray = [[aDecoder decodeObjectForKey:@"foodArray"] mutableCopy];
    }
    return self;
}

//Searches linearly for the item in the list.
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
// Removes an item.
-(void)removeFoodItemAtIndex:(int)index
{
    FoodItem *removalItem = [self.foodArray objectAtIndex:index];
    //If the quantity is more than 1 just decrement
    if (removalItem.quantity > 1)
        removalItem.quantity--;
	//otherwise remove the entry.
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

@end
