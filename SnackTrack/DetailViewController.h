//
//  DetailViewController.h
//  Test
//
//  Created by Thomas Borgia on 4/17/14.
//  Copyright (c) 2014 Synthecode. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodItem;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) FoodItem *detailItem;
@property (strong, nonatomic) IBOutlet UILabel *upcLabel;
@property (strong, nonatomic) IBOutlet UILabel *expiryLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property IBOutlet UINavigationItem *navigationItem;

@end