//
//  FoodItem.h
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *upcCode;
@property (nonatomic, copy) NSString *expiryDate;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *avgUseTime;

-(id)initWithUPC:(NSString *)inUPC;

@end
