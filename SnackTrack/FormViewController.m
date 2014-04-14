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
    
    self.foodName.delegate = self;
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

-(IBAction)clickScan:(id)sender
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology:ZBAR_UPCA config:ZBAR_CFG_ENABLE to: 0];
    
    // present and release the controller
    [self presentViewController:reader animated:YES completion:nil];
}

-(IBAction)clickAdd:(id)sender
{
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    FoodItem *item = [[FoodItem alloc] initWithUPC:self.upc.text];
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

- (void) imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    //Removes the leading 0 from the UPC string
    NSString *upcCode = [symbol.data substringFromIndex:1];
    
    self.upc.text = upcCode;
    
    [reader dismissViewControllerAnimated:YES completion:nil];
    
    //[self presentViewController:form animated:YES completion:nil];
    
    FoodItem *item = [[FoodItem alloc] initWithUPC:upcCode];
    NSLog(@"Item name: %@", item.name);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
