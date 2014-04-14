//
//  FormViewController.h
//  SnackTrack
//
//  Created by Thomas Borgia on 4/10/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface FormViewController : UIViewController <ZBarReaderDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *foodName;
@property (nonatomic, weak) IBOutlet UITextField *upc;
@property (nonatomic, weak) IBOutlet UITextField *expiryDate;
@property (nonatomic, weak) IBOutlet UITextField *description;
@property (nonatomic, weak) IBOutlet UITextField *avgUseTime;

-(IBAction)clickAdd:(id)sender;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
