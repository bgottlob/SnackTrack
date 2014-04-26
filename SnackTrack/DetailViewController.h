//
//  DetailViewController.h
//
//  Created by Thomas Borgia on 4/17/14.
//  Copyright (c) 2014 Synthecode. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodItem;

@interface DetailViewController : UIViewController

//Properties of the food item
@property (strong, nonatomic) FoodItem *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *upcLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiryLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property IBOutlet UINavigationItem *navigationItem;

-(IBAction)clickEdit:(id)sender;

@end