//
//  EditViewController.m
//  SnackTrack
//
//  Created by Thomas Borgia on 4/21/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "AppDelegate.h"
#import "EditViewController.h"
#import "FoodItem.h"
#import "FoodList.h"

@implementation EditViewController

@synthesize qtyField, foodName, upc, expiryDate, description, rowNo, scrollView, keyboardIsShown, datePicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Makes sure that user interface elements do not appear underneath the navigation bar in iOS 7
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //504 is the height of the scroll view on iPhone 5 screens!!!!
    [self.scrollView setContentSize:CGSizeMake(320, 504)];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    self.keyboardIsShown = NO;
    
    //Setup UIStepper for quantity value
    [self.stepper setMinimumValue:1];
    [self.stepper setContinuous:YES];
    [self.stepper setWraps:NO];
    [self.stepper setStepValue:1];
    [self.stepper setMaximumValue:100];
    [self.stepper setValue:((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).quantity];
    
    self.foodName.delegate = self;
    self.upc.delegate = self;
    self.expiryDate.delegate = self;
    self.description.delegate = self;
    self.qtyField.delegate = self;
    
    //Setup UIDatePicker for expiration date input
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker setDate:[NSDate date]];
    [datePicker setMinimumDate: [NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [expiryDate setInputView:datePicker];
    
    qtyField.text = [NSString stringWithFormat:@"%i",(int)((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).quantity];
    foodName.text = ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).name;
    upc.text = ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).upcCode;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    expiryDate.text = [formatter stringFromDate:((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).expiryDate];
    description.text = ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).description;
}

- (void)keyboardWillHide:(NSNotification *)n
{
    CGRect viewFrame = self.scrollView.frame;
    viewFrame.size.height = 504;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = NO;
}

//Scrolls the view so the text field is visible above the keyboard – called when the keyboard is about to be shown
- (void)keyboardWillShow:(NSNotification *)n
{
    //Ensures that frame adjustment is not done when the keyboard is not being shown
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect viewFrame = self.scrollView.frame;
    viewFrame.size.height -= (keyboardSize.height + 10);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

//This method is required to allow the scroll view to scroll
-(void)viewDidLayoutSubviews
{
    [scrollView setContentSize:CGSizeMake(320, 504)];
}

-(IBAction)clickDone:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).quantity = [qtyField.text intValue];
    ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).name = foodName.text;
    ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).upcCode = upc.text;
    ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).expiryDate = [formatter dateFromString:expiryDate.text];
    ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).description = description.text;
    
    //Saves the new properties of the food item
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"foodList.txt"];
    
    [NSKeyedArchiver archiveRootObject:appDelegate.foodList toFile:appFile];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickCancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([expiryDate isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)expiryDate.inputView;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        expiryDate.text = [dateFormatter stringFromDate:picker.date];
    }
}

-(void)updateTextField:(id)sender
{
    if([expiryDate isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)expiryDate.inputView;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        expiryDate.text = [dateFormatter stringFromDate:picker.date];
    }
}

-(IBAction)stepperPressed:(UIStepper *)sender
{
    self.qtyField.text= [NSString stringWithFormat:@"%i", (int)sender.value];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.foodName) {
        [self.upc becomeFirstResponder];
    } else if (textField == self.upc) {
        [self.description becomeFirstResponder];
    } else if (textField == self.description) {
        [self.expiryDate becomeFirstResponder];
    } else if (textField == self.expiryDate) {
        [self.expiryDate resignFirstResponder];
    }
    return YES;
}

-(IBAction)clickBackground:(id)sender
{
    [self.foodName resignFirstResponder];
    [self.upc resignFirstResponder];
    [self.description resignFirstResponder];
    [self.expiryDate resignFirstResponder];
    [self.qtyField resignFirstResponder];
    [self.datePicker resignFirstResponder];
}

@end
