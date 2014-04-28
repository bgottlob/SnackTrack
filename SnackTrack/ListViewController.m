//
//  ListViewController.m
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/9/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "FormViewController.h"
#import "EditViewController.h"
#import "FoodList.h"
#import "FoodItem.h"
#import "AppDelegate.h"

//Controls ListViewController (Snack List)
@implementation ListViewController

@synthesize foodTable, deleteIndex;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Makes sure that user interface elements do not appear underneath the navigation bar in iOS 7
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    foodTable.delegate = self;
    foodTable.dataSource = self;
    
    [foodTable setBackgroundColor:[UIColor clearColor]];
}

//Called whenever a list view is about to appear
-(void)viewWillAppear:(BOOL)animated
{
    [foodTable reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //Get a reference to the current item and fill the fields of the cell
    FoodItem *item = [appDelegate.foodList.foodArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:item.name];
    [cell.imageView setImage:item.image];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

//Called when the user swipes to the left and clicks "delete"
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        FoodItem *foodToDelete = [appDelegate.foodList.foodArray objectAtIndex:indexPath.row];
        deleteIndex = 0;
        
        //If quanitity of food item in greater than 1 show message to ask user how many items to delete
        if (foodToDelete.quantity > 1)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:[@"How many of this item would you like to delete? You can delete up to: " stringByAppendingString:[NSString stringWithFormat:@"%d",foodToDelete.quantity]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", @"Delete All", nil];
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView textFieldAtIndex:0].delegate = self;
            [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
            [alertView show];
        }
        else
        {
            [appDelegate.foodList.foodArray removeObjectAtIndex:indexPath.row];
        
            // Delete the row from the data source
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            //Save the updated food list
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"foodList.txt"];
            
            [NSKeyedArchiver archiveRootObject:appDelegate.foodList toFile:appFile];
            
            // Request table view to reload
            [tableView reloadData];
        }
    }
}

//Sends data to the detail view controller that is pushed to when a row is selected
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.foodTable indexPathForSelectedRow];
        FoodItem *foodItem = [appDelegate.foodList.foodArray objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:foodItem];
        [[segue destinationViewController] setRowNo:(int)indexPath.row];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return [appDelegate.foodList.foodArray count];
}

//Responds to clicking a button on an alert view – the actual deletion actions are handled here
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Delete"])
    {
        int quantity = [[alertView textFieldAtIndex:0].text intValue];
        BOOL removeSuccess = [appDelegate.foodList removeMultipleObjects:quantity atIndex:deleteIndex];
        
        //If the quanitity is too large to delete alert user
        if(removeSuccess == NO)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"The quantity you asked to delete was too large. Nothing was deleted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];

        }
    }
    //delete entire object
    else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Delete All"])
    {
        FoodItem *deleteItem = [appDelegate.foodList.foodArray objectAtIndex:deleteIndex];
        
        BOOL removeSuccess = [appDelegate.foodList removeMultipleObjects:deleteItem.quantity atIndex:deleteIndex];
        if(removeSuccess == NO)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"The quantity you asked to delete was too large. Nothing was deleted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"foodList.txt"];
    
    [NSKeyedArchiver archiveRootObject:appDelegate.foodList toFile:appFile];
    
    [self.foodTable reloadData];
}

-(IBAction)clickDelete:(id)sender
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

//Called once the barcode of the item to be deleted is scanned
-(void)imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    FoodItem *searchItem = [[FoodItem alloc] init];
    searchItem.upcCode = symbol.data;
    
    [reader dismissViewControllerAnimated:YES completion:nil];
    
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    deleteIndex = [appDelegate.foodList searchForFoodItem:searchItem];
    
    if (deleteIndex != -1)
    {
        //The item was found and can be deleted
        FoodItem *deleteItem = [appDelegate.foodList.foodArray objectAtIndex:deleteIndex];
        
        NSString *alertMessage = [[NSString stringWithFormat:@"How many %@ would you like to delete? You can delete up to: ", deleteItem.name] stringByAppendingString:[NSString stringWithFormat:@"%d",deleteItem.quantity]];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:alertMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", @"Delete All", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView textFieldAtIndex:0].delegate = self;
        [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
        [alertView show];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This item was not found in your inventory" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    
    [self.foodTable reloadData];
    
}

@end
