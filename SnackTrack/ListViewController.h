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

//The index in the food list array the item to be deleted is located
@property (nonatomic) int deleteIndex;

//Shows a barcode reader view so the user can scan the item to be deleted
-(IBAction)clickDelete:(id)sender;

@end