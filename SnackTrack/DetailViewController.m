//
//  DetailViewController.m
//  Test
//
//  Created by Thomas Borgia on 4/17/14.
//  Copyright (c) 2014 Synthecode. All rights reserved.
//

#import "DetailViewController.h"
#import "FoodItem.h"

@implementation DetailViewController

@synthesize detailItem, navigationItem, imageView, nameLabel;

- (void)configureView
{
    // Update the user interface for the detail item.
	// Checks if each property is initialized before displaying
    if (self.detailItem) {
        
        self.nameLabel.text = detailItem.name;
        
        if (detailItem.upcCode)
            self.upcLabel.text = [@"UPC: " stringByAppendingString:detailItem.upcCode];
        if (detailItem.expiryDate)
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM-dd-yyyy"];
            self.expiryLabel.text = [@"Expiry Date: " stringByAppendingString:[formatter stringFromDate:detailItem.expiryDate]];
        }
        if (detailItem.description)
            self.descLabel.text = [@"Description: " stringByAppendingString:detailItem.description];
        if (detailItem.image)
            [self.imageView setImage:detailItem.image];
        
        self.quantityLabel.text = [NSString stringWithFormat:@"Quantity: %i", detailItem.quantity];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Makes sure that user interface elements do not appear underneath the navigation bar in iOS 7
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureView];
}

//This method is called just before a view becomes visible to the user
-(void)viewWillAppear:(BOOL)animated
{
    [self configureView];
    [super viewWillAppear:animated];
    
    self.navigationItem.title = self.detailItem.name;
}

//moves to edit view
-(IBAction)clickEdit:(id)sender
{
    [self performSegueWithIdentifier: @"editFood" sender:detailItem];
}

@end