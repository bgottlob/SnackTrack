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

@synthesize foodName, upc, expiryDate, description, rowNo;

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
    // Do any additional setup after loading the view.
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Setup UIDatePicker for expiration date input
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [expiryDate setInputView:datePicker];
    
    foodName.text = ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).name;
    upc.text = ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).upcCode;
    expiryDate.text = ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).expiryDate;
    description.text = ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickDone:(id)sender
{
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).name = foodName.text;
    ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).upcCode = upc.text;
    ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).expiryDate = expiryDate.text;
    ((FoodItem*)[appDelegate.foodList.foodArray objectAtIndex:rowNo]).description = description.text;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"foodList.txt"];
    
    [NSKeyedArchiver archiveRootObject:appDelegate.foodList toFile:appFile];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)clickCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.foodName) {
        [self.upc becomeFirstResponder];
    } else if (textField == self.upc) {
        [self.expiryDate becomeFirstResponder];
    } else if (textField == self.expiryDate) {
        [self.description becomeFirstResponder];
    } else if (textField == self.description) {
        [self.description resignFirstResponder];
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
