//
//  UPCParser.m
//  SnackTrack
//
//  Created by Nathaniel Milkosky on 4/8/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "UPCParser.h"
#import "FoodItem.h"

@implementation UPCParser

+(NSDictionary *)parseUPC:(NSString*)upcCode
{
    NSString *url = @"http://www.outpan.com/api/get_product.php?barcode=";
    if (upcCode)
        url = [url stringByAppendingString:upcCode];
    
    //Create and send an HTTP request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *parseError = nil;
    
    //Serialize the data into an NSDictionary object
    NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:response options:0 error:&parseError];
    
    return jsonObj;
}

+(void)addToDatabase:(FoodItem *)item
{
    //Preparing URL
    NSString *url = @"http://www.outpan.com/api/add_product.php?api_key=178dd9ebfc6d574e64b014c29ba7fb6d&barcode=";
    if (item.upcCode)
        url = [url stringByAppendingString:[item upcCode]];
    
    //Prepare the information in Product Markup Language (PDL) for database
    NSString *pdlName = [NSString stringWithFormat:@"<name>%@</name>",[item name]];
    NSString *pdlDesc = [NSString stringWithFormat:@"<description>%@</description>",[item description]];
    NSString *completedPDL = [NSString stringWithFormat:@"data=%@\n%@", pdlName, pdlDesc];
    NSData *requestInfo = [completedPDL dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@  %@", completedPDL, requestInfo);
    //Create and send an HTTP POST request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:requestInfo];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"]; //ensures proper data type is recieved
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}




@end
