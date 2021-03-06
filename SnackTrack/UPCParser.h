//
//  UPCParser.h
//  SnackTrack
//
//  Created by Nathaniel Milkosky on 4/8/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//
//Parses the information for each food item
//from the database

#import <Foundation/Foundation.h>
@class FoodItem;
@interface UPCParser : NSObject

//Returns a dictionary filled with information about a product with the given UPC Code
+(NSDictionary *)parseUPC:(NSString*)upcCode;

//Adds an item to the database
+(void)addToDatabase:(FoodItem*)upcCode;

@end