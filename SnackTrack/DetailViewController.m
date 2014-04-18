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

@synthesize detailItem, foodNameLabel;

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.foodNameLabel.text = self.detailItem.name;
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
}

@end
