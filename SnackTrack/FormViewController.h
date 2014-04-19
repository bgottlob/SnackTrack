//
//  FormViewController.h
//  SnackTrack
//
//  Created by Thomas Borgia on 4/10/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface FormViewController : UIViewController <ZBarReaderDelegate, UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *foodName;
@property (nonatomic, weak) IBOutlet UITextField *upc;
@property (nonatomic, weak) IBOutlet UITextField *expiryDate;
@property (nonatomic, weak) IBOutlet UITextField *description;
@property (nonatomic, weak) IBOutlet UITextField *avgUseTime;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic) BOOL keyboardIsShown;

@property (nonatomic) BOOL willAddToDB;

-(IBAction)clickAdd:(id)sender;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(IBAction)clickCancel:(id)sender;

@end
