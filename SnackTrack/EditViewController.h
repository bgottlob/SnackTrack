//
//  EditViewController.h
//  SnackTrack
//
//  Created by Thomas Borgia on 4/21/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodItem;

@interface EditViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>

@property (nonatomic, assign) int rowNo;

//Text fields that allow the user to edit the properties of a food item
@property (nonatomic, weak) IBOutlet UITextField *qtyField;
@property (nonatomic, weak) IBOutlet UITextField *foodName;
@property (nonatomic, weak) IBOutlet UITextField *upc;
@property (nonatomic, weak) IBOutlet UITextField *expiryDate;
@property (nonatomic, weak) IBOutlet UITextField *description;

//editing view that moves to selected field
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) IBOutlet UIStepper* stepper;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic) BOOL keyboardIsShown;

//Saves the edited changes to the food item
-(IBAction)clickDone:(id)sender;

//Dismisses the view and returns to the detail view
-(IBAction)clickCancel:(id)sender;

//Responds to the stepper being pressed – increments or decrements the quantity
-(IBAction)stepperPressed:(UIStepper *)sender;

//Responds to the user clicking the return button on the keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField;

//Dismisses the keyboard or date picker when the background of the view is pressed
-(IBAction)clickBackground:(id)sender;


@end
