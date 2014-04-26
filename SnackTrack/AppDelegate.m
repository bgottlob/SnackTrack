//
//  AppDelegate.m
//  SnackTrack
//
//  Created by Brandon Gottlob on 3/31/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "AppDelegate.h"
#import "FoodList.h"
#import "FoodItem.h"

@implementation AppDelegate

@synthesize foodList;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    foodList = [[FoodList alloc] init];
    
    //Get the filename of the text file that the food list object is saved in
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *listFile = [documentsDirectory stringByAppendingPathComponent:@"foodList.txt"];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    //If the file exists, read its contents, if not, foodList was initialized already
    if ([fileManager fileExistsAtPath:listFile])
    {
        foodList = [NSKeyedUnarchiver unarchiveObjectWithFile:listFile];
    }
    
    [self sendExpirationNotifications];
    
    return YES;
}

-(void)sendExpirationNotifications
{
    for (FoodItem *item in foodList.foodArray)
    {
        if (item.expiryDate != nil)
        {
            NSTimeInterval secondsInADay = 86400;
            NSTimeInterval secondsFromNow = [item.expiryDate timeIntervalSinceNow];
            
            if (secondsFromNow < 0) //If the time interval is negative, the expiration date has passed
            {
                NSString *alertMessage = [NSString stringWithFormat:@"Your %@ has expired!", item.name];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Expiration Notification" message:alertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else if (secondsFromNow <= secondsInADay * 2) //If the time interval is within 2 days, display a notification
            {
                NSString *alertMessage = [NSString stringWithFormat:@"Your %@ is going to expire within 2 days!", item.name];
                
                if (secondsFromNow <= secondsInADay)
                {
                    alertMessage = [NSString stringWithFormat:@"Your %@ is going to expire within 1 day!", item.name];
                }
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Expiration Notification" message:alertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
    }
}
				
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
