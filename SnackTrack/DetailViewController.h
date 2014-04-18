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

@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;

@end
