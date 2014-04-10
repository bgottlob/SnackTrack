//
//  UPCdelegate.h
//  SnackTrack
//
//  Created by Nathaniel Milkosky on 4/8/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPCdelegate : NSObject <NSXMLParserDelegate>
{
    NSMutableString *currentElementValue;
    NSMutableDictionary *item;
}

@property (nonatomic, strong) NSMutableDictionary *item;

-(UPCdelegate *)initUPCdelegate;

@end