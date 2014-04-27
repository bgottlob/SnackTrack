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

@implementation ListViewController

@synthesize foodTable, deleteIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

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
    
    NSDate *object = appDelegate.foodList.foodArray[indexPath.row];
    cell.textLabel.text = [object description];
    
    //Get a reference to the current item
    FoodItem *item = [appDelegate.foodList.foodArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:item.name];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        FoodItem *foodToDelete = [appDelegate.foodList.foodArray objectAtIndex:indexPath.row];
        deleteIndex = 0;
        
        if (foodToDelete.quantity > 1)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You have more than one of this item.  Would you like to delete one or all of them?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Just One", @"All", nil];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.foodTable indexPathForSelectedRow];
        FoodItem *foodItem = [appDelegate.foodList.foodArray objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:foodItem];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Get a reference to the AppDelegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Just One"])
    {
        [appDelegate.foodList removeFoodItemAtIndex:deleteIndex];
    }
    else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"All"])
    {
        [appDelegate.foodList.foodArray removeObjectAtIndex:deleteIndex];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"foodList.txt"];
    
    [NSKeyedArchiver archiveRootObject:appDelegate.foodList toFile:appFile];
    
    [self.foodTable reloadData];
}

@end
