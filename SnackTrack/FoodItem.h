//
//  FoodItem.h
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) int upcCode;

-(id)initWithUPC:(NSString *)inUPC;

@end
