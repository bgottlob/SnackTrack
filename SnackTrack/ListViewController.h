//
//  ListViewController.h
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//
//Controls ListViewController (Snack List)

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate, ZBarReaderDelegate>

@property (nonatomic, weak) IBOutlet UITableView *foodTable;

@property (nonatomic) int deleteIndex;

-(IBAction)clickDelete:(id)sender;

@end