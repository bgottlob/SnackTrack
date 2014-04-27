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

//Properties of the food item
@property (nonatomic, weak) IBOutlet UITextField *qtyField;
@property (nonatomic, weak) IBOutlet UITextField *foodName;
@property (nonatomic, weak) IBOutlet UITextField *upc;
@property (nonatomic, weak) IBOutlet UITextField *expiryDate;
@property (nonatomic, weak) IBOutlet UITextField *description;

//editing view that moves to selected field
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) IBOutlet UIStepper* stepper;

@property (nonatomic) BOOL keyboardIsShown;

//actions
-(IBAction)clickDone:(id)sender;
-(IBAction)clickCancel:(id)sender;
-(IBAction)stepperPressed:(UIStepper *)sender;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;


@end
