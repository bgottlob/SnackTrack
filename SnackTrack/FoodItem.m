//
//  FoodItem.m
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "FoodItem.h"
#import "UPCParser.h"

@implementation FoodItem

@synthesize name, upcCode;

-(id)initWithUPC:(NSString *)inUPC
{
    if (self = [super init])
    {
        upcCode = [inUPC intValue];
        NSLog(@"inUPC: %@", inUPC);
        NSDictionary *itemData = [UPCParser parseUPC:inUPC];
        name = [itemData valueForKey:@"description"];
    }
    
    return self;
}

@end
