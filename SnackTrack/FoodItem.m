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

        NSDictionary *itemData = [UPCParser parseUPC:inUPC];
        name = [itemData valueForKey:@"description"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:upcCode forKey:@"upcCode"];
    [aCoder encodeObject:name forKey:@"name"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.upcCode = [aDecoder decodeIntForKey:@"upcCode"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
