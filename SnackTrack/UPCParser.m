//
//  UPCParser.m
//  SnackTrack
//
//  Created by Nathaniel Milkosky on 4/8/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "UPCParser.h"

@implementation UPCParser

+(NSDictionary *)parseUPC:(NSString*)upcCode
{
    //Generating a URL to feed to the API
    NSString *combined = [@"http://api.upcdatabase.org/xml/e9b06e801511e9b6492ac371850bdc83/" stringByAppendingString:upcCode];
    NSURL *xmlURL = [[NSURL alloc] initWithString:combined];
    NSXMLParser *XMLupcparser =[[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    
    UPCdelegate *parser = [[UPCdelegate alloc] initUPCdelegate];
    [XMLupcparser setDelegate:parser];
    
    BOOL success = [XMLupcparser parse];
    if(success){
        NSMutableDictionary *itemData = [parser item];
        return itemData;
    }
    
    return NULL;
}

@end