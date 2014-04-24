//
//  EditViewController.h
//  SnackTrack
//
//  Created by Thomas Borgia on 4/21/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodItem;

@interface EditViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) int rowNo;

@property (nonatomic, weak) IBOutlet UITextField *foodName;
@property (nonatomic, weak) IBOutlet UITextField *upc;
@property (nonatomic, weak) IBOutlet UITextField *expiryDate;
@property (nonatomic, weak) IBOutlet UITextField *description;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic) BOOL keyboardIsShown;

-(IBAction)clickDone:(id)sender;
-(IBAction)clickCancel:(id)sender;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;


@end
