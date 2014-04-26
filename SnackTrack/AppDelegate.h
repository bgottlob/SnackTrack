//
//  AppDelegate.h
//  SnackTrack
//
//  Created by Brandon Gottlob on 3/31/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodList;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//Stores the user's list of food items
@property (nonatomic, strong) FoodList *foodList;

-(void)sendExpirationNotifications;

@end
