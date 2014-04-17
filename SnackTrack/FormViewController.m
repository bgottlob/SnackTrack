//
//  FormViewController.m
//  SnackTrack
//
//  Created by Thomas Borgia on 4/10/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "FormViewController.h"
#import "FoodList.h"
#import "FoodItem.h"
#import "AppDelegate.h"

@implementation FormViewController

@synthesize foodName, upc, expiryDate, description, avgUseTime;

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
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.foodName.delegate = self;
    self.upc.delegate = self;
    self.expiryDate.delegate = self;
    self.description.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(IBAction)clickAdd:(id)sender
{
    //Get a reference to the AppDelegate object
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     
     FoodItem *item = [[FoodItem alloc] initWithUPC:upc.text];
     item.name = self.foodName.text;
     item.expiryDate = self.expiryDate.text;
     item.description = self.description.text;
     item.avgUseTime = self.avgUseTime.text;
     
     [appDelegate.foodList addFoodItem:item];
     
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"foodList.txt"];
     
     [NSKeyedArchiver archiveRootObject:appDelegate.foodList toFile:appFile];
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
    
    FoodItem *item = [[FoodItem alloc] initWithUPC:upcCode];
    self.foodName.text = item.name;
    NSLog(@"Item name: %@", item.name);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
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

@end
