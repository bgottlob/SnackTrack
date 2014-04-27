//
//  FoodItem.m
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//


#import "FoodItem.h"
#import "UPCParser.h"

//Creates FoodItem objects for specific UPC codes and compares FoodItems
@implementation FoodItem

@synthesize name, upcCode, description, DBattributes, quantity, expiryDate, image;

//Constructs a food item from a specific UPC code.
-(id)initWithUPC:(NSString *)inUPC errorCode:(int *)errorCode
{
	//Initiate the superclass - if it fails do not execute the following
    if (self = [super init])
    {
		//Set up item attributes
        quantity = 1;
        upcCode = inUPC;
        NSDictionary *itemData = [UPCParser parseUPC:inUPC]; //check against the database and initialize a dictionary from the data
        name = [itemData valueForKey:@"name"];
        description = [itemData valueForKey:@"description"];
        
        //Error checking
        NSDictionary *error = [itemData objectForKey:@"error"];
        NSLog(@"Error: %@", error);
        
        if (error)
        {
            *errorCode = [[error valueForKey:@"code"] intValue];
        }
        
        if([itemData objectForKey:@"attributes"] != nil) // if there is an attribute key, copy over
        {
            DBattributes = [itemData objectForKey:@"attributes"]; //using object for key because we are getting more than a simple string or value
        } else { //if there isn't an attribute key, make an empty one
            DBattributes = [[NSMutableDictionary alloc] init];
        }
        
        NSArray *images = [itemData objectForKey:@"images"];
        if (images)
        {
            //Just returns the URL of the first image in the array
            NSString *imageURL = [images objectAtIndex:0];
            NSURL *url = [NSURL URLWithString:imageURL];
            NSData *data = [NSData dataWithContentsOfURL:url];
            self.image = [[UIImage alloc] initWithData:data];
        }
        
    }
    
    return self;
}

//Encodes the object into data for storage
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:upcCode forKey:@"upcCode"];
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:description forKey:@"description"];
    [aCoder encodeInt:quantity forKey:@"quantity"];
    [aCoder encodeObject:DBattributes forKey:@"attributes"];
    [aCoder encodeObject:expiryDate forKey:@"expiryDate"];
    [aCoder encodeObject:image forKey:@"image"];
}
//Constructs the object from decoded data
-(id)initWithCoder:(NSCoder *)aDecoder
{
	//Initiate the superclass - if it fails do not execute the following
    if (self = [super init])
    {
        self.upcCode = [aDecoder decodeObjectForKey:@"upcCode"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.description = [aDecoder decodeObjectForKey:@"description"];
        self.quantity = [aDecoder decodeIntForKey:@"quantity"];
        self.DBattributes = [aDecoder decodeObjectForKey:@"attributes"];
        self.expiryDate = [aDecoder decodeObjectForKey:@"expiryDate"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}

//Checks if a food item is equal to another.
-(BOOL)isEqualToFoodItem:(FoodItem *)otherItem
{
	//First try to compare upc codes, then try comparing the names.
    if (self.upcCode != nil && otherItem.upcCode != nil)
    {
        return [self.upcCode isEqualToString:otherItem.upcCode];
    }
    else
    {
        //Comparison of name is not case sensitive
        return [[self.name uppercaseString] isEqualToString:[otherItem.name uppercaseString]];
    }
}

//will return NSOrderedSame if names are the same
//will return NSOrderedAscending if self goes after otherItem
//will return NSOrderedDescending if self goes before otherItem
- (NSComparisonResult)compareTo:(FoodItem *)otherItem
{
    NSComparisonResult res = [self.name caseInsensitiveCompare:otherItem.name];
    return res;
}
//compareTo is not currently implemented in application



@end
