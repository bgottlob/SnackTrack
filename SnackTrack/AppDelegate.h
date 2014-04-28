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

//Checks if any food in the list is about to expire and shows alert views on the screen when the user opens the app if any items are going to expire within 2 days
-(void)sendExpirationNotifications;

@end
