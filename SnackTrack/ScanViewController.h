//
//  ScanViewController.h
//  SnackTrack
//
//  Created by Brandon Gottlob on 4/8/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ScanViewController : UIViewController <ZBarReaderDelegate>

@property (nonatomic, weak) IBOutlet UILabel *upcLabel;
-(IBAction)clickScan:(id)sender;

@end
