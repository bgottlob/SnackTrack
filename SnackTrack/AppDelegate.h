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

@property (nonatomic, strong) FoodList *foodList;

@end
