//
//  FormViewController.h
//  SnackTrack
//
//  Created by Thomas Borgia on 4/10/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@class FoodItem;

@interface FormViewController : UIViewController <ZBarReaderDelegate, UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate>
//The information about the item.
@property (nonatomic, weak) IBOutlet UITextField *qtyField;
@property (nonatomic, weak) IBOutlet UITextField *foodName;
@property (nonatomic, weak) IBOutlet UITextField *upc;
@property (nonatomic, weak) IBOutlet UITextField *expiryDate;
@property (nonatomic, weak) IBOutlet UITextField *description;
//Information about the view that scrolls the fields
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic) BOOL keyboardIsShown;

@property (nonatomic) BOOL willAddToDB;
@property (strong, nonatomic) FoodItem *detailItem;
@property (nonatomic, strong) FoodItem *itemToAdd;
@property (nonatomic, weak) IBOutlet UIStepper* stepper;
@property (nonatomic, strong) UIDatePicker *datePicker;

//Actions
-(IBAction)clickAdd:(id)sender;
-(IBAction)clickCancel:(id)sender;
-(IBAction)stepperPressed:(id)sender;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(IBAction)clickBackground:(id)sender;

@end
