//
//  UPCdelegate.h
//  SnackTrack
//
//  Created by Nathaniel Milkosky on 4/8/14.
//  Copyright (c) 2014 Brandon Gottlob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPCdelegate : NSObject
    {
            NSMutableString *currentElementValue;
            NSMutableDictionary *item;
    }
    
    @property (nonatomic, retain) NSMutableDictionary *item;
    
    - (UPCdelegate *) initUPCdelegate;
    
@end
