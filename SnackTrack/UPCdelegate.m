//
//  UPCdelegate.m
//  SnackTrack
//
//  Created by Nathaniel Milkosky on 4/8/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import "UPCdelegate.h"

@implementation UPCdelegate
    @synthesize item;
    -(UPCdelegate *) initUPCdelegate {
        item = [[NSMutableDictionary alloc] init];
        return [super init];
    }
    
    - (void)parser:(NSXMLParser *)parser
   didStartElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qualifiedName
        attributes:(NSDictionary *)attributeDict {
        
        if ([elementName isEqualToString:@"output"]) {
        }
    }
    
    - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
        if (!currentElementValue) {
            // init the ad hoc string with the value
            NSLog(@"IF %@", string);
            currentElementValue = [[NSMutableString alloc] initWithString:string];
        } else {
            // append value to the ad hoc string
            NSLog(@"ELSE %@", string);
            [currentElementValue appendString:string];
        }
    }
    
    - (void)parser:(NSXMLParser *)parser
     didEndElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName {
        
        if ([elementName isEqualToString:@"output"]) {
            // We reached the end of the XML document
            return;
        } else {
            // The parser hit one of the element values.
            // This syntax is possible because User object
            // property names match the XML user element names
            if([currentElementValue length] >= 2)
            {
                [item setValue:[currentElementValue substringFromIndex:2] forKey:elementName];
            }
            else
            {
                [item setValue:currentElementValue forKey:elementName];
            }
        }
        
        currentElementValue = nil;
    }
@end
