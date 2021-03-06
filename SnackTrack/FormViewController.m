//
//  FormViewController.m
//  SnackTrack
//
//  Created by Thomas Borgia on 4/10/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "FormViewController.h"
#import "EditViewController.h"
#import "FoodList.h"
#import "FoodItem.h"
#import "AppDelegate.h"
#import "UPCParser.h"

@implementation FormViewController

@synthesize foodName, upc, expiryDate, description, keyboardIsShown, scrollView, willAddToDB, itemToAdd, detailItem, stepper, datePicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Makes sure that user interface elements do not appear underneath the navigation bar in iOS 7
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //Setup UIStepper for quantity value
    [self.stepper setMinimumValue:1];
    [self.stepper setContinuous:YES];
    [self.stepper setWraps:NO];
    [self.stepper setStepValue:1];
    [self.stepper setMaximumValue:100];
    self.qtyField.text = [NSString stringWithFormat:@"%i",(int)self.stepper.value];
    
    itemToAdd = [[FoodItem alloc] init];
    
    self.foodName.delegate = self;
    self.upc.delegate = self;
    self.expiryDate.delegate = self;
    self.description.delegate = self;
    self.qtyField.delegate = self;
    
    foodName.text = detailItem.name;
    
    //Setup UIDatePicker for expiration date input
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker setDate:[NSDate date]];
    [datePicker setMinimumDate: [NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [expiryDate setInputView:datePicker];
    
    //504 is the height of the scroll view on iPhone 5 screens!!!!
    [self.scrollView setContentSize:CGSizeMake(320, 504)];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    self.keyboardIsShown = NO;
    
    self.willAddToDB = NO;
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

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.scrollView.frame;
    viewFrame.size.height -= (keyboardSize.height + 10);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

//This method is required to allow the scroll view to scroll for some reason
-(void)viewDidLayoutSubviews
{
    [scrollView setContentSize:CGSizeMake(320, 504)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickAdd:(id)sender
{
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    itemToAdd.name = self.foodName.text;
    
    if ([self.upc.text isEqualToString:@""])
        itemToAdd.upcCode = nil;
    else
        itemToAdd.upcCode = self.upc.text;
    
    if ([self.upc.text isEqualToString:@""])
        itemToAdd.description = nil;
    else
        itemToAdd.description = self.description.text;
    
    itemToAdd.quantity = [[self.qtyField text] intValue];

    [appDelegate.foodList addFoodItem:itemToAdd];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"foodList.txt"];

    [NSKeyedArchiver archiveRootObject:appDelegate.foodList toFile:appFile];

    if (willAddToDB)
        [UPCParser addToDatabase:itemToAdd];

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"No"])
    {
        willAddToDB = NO;
    }
    else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"])
    {
        willAddToDB = YES;
    }
}

-(IBAction)clickCancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickScan:(id)sender
{
    // Present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    // Disable all symbologies
    [scanner setSymbology: 0 config: ZBAR_CFG_ENABLE to: 0];
    
    // Enable EAN 13 - For European products
    [scanner setSymbology: ZBAR_EAN13 config: ZBAR_CFG_ENABLE to: 1];
    
    // Enable UPC-A – For American products
    [scanner setSymbology: ZBAR_UPCA config: ZBAR_CFG_ENABLE to: 1];
    
    // present and release the controller
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    NSString *upcCode = symbol.data;
    
    [reader dismissViewControllerAnimated:YES completion:nil];
    
    self.upc.text = upcCode;
    
    int dbErrorCode = 0;
    itemToAdd = [[FoodItem alloc] initWithUPC:upcCode errorCode:&dbErrorCode];
    self.foodName.text = itemToAdd.name;
    
    if (dbErrorCode == 100)
    {
        UIAlertView *notFoundAlert = [[UIAlertView alloc] initWithTitle:@"Item Not Found" message:@"This item has not been found in our database.  Would you like to add it to the database?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [notFoundAlert show];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([expiryDate isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)expiryDate.inputView;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        expiryDate.text = [dateFormatter stringFromDate:picker.date];
        itemToAdd.expiryDate = picker.date;
    }
}

-(void)updateTextField:(id)sender
{
    if([expiryDate isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)expiryDate.inputView;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        expiryDate.text = [dateFormatter stringFromDate:picker.date];
        itemToAdd.expiryDate = picker.date;
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
