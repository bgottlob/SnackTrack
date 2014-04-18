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

@synthesize detailItem, navigationItem;

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.upcLabel.text = [@"UPC: " stringByAppendingString:detailItem.upcCode];
        self.expiryLabel.text = [@"Expiry Date: " stringByAppendingString:detailItem.expiryDate];
        self.descLabel.text = [@"Description: " stringByAppendingString:detailItem.description];
        self.avgTimeLabel.text = [@"Average Use Time: " stringByAppendingString:detailItem.avgUseTime];
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

@end
