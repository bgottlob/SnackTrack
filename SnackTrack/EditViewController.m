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

@interface EditViewController ()

@end

@implementation EditViewController

@synthesize qtyField, foodName, upc, expiryDate, description, rowNo, scrollView, keyboardIsShown;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
