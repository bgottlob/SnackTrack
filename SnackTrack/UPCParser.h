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

+(NSDictionary *)parseUPC:(NSString*) upcCode;
    
@end
