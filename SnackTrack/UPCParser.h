//
//  UPCParser.h
//  SnackTrack
//
//  Created by Nathaniel Milkosky on 4/8/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPCDelegate.h"

@interface UPCParser : NSObject

//Returns a dictionary filled with information about a product with the given UPC Code
+(NSDictionary *)parseUPC:(NSString*)upcCode;

@end