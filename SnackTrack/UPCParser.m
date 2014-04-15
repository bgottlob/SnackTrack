//
//  UPCParser.m
//  SnackTrack
//
//  Created by Nathaniel Milkosky on 4/8/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "UPCParser.h"

@implementation UPCParser

/*+(NSDictionary *)parseUPC:(NSString*)upcCode
{
    //Generating a URL to feed to the API
    NSString *combined = [@"http://api.upcdatabase.org/xml/e9b06e801511e9b6492ac371850bdc83/" stringByAppendingString:upcCode];
    NSURL *xmlURL = [[NSURL alloc] initWithString:combined];
    
    //Start the parser with data from the specified URL
    NSXMLParser *XMLupcparser =[[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    
    //Set up the delagate for the parser
    UPCdelegate *parser = [[UPCdelegate alloc] initUPCdelegate];
    [XMLupcparser setDelegate:parser];
    
    //Parse the data and store if it was successful or not
    BOOL success = [XMLupcparser parse];
    
    //If it was successful, create the dictionary and return it
    if(success){
        NSMutableDictionary *itemData = [parser item];
        return itemData;
    }
    
    //If it wasn't successful, return NULL;
    return NULL;
}*/

+(NSDictionary *)parseUPC:(NSString*)upcCode
{
    NSString *url = @"http://www.outpan.com/api/get_product.php?barcode=";
    url = [url stringByAppendingString:upcCode];
    
    //Create and send an HTTP request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *parseError = nil;
    NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:response options:0 error:&parseError];
    
    return jsonObj;
}

@end
