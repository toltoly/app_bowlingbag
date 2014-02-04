//
//  BBAppState.h
//  BowlingBag
//
//  Created by Won Kim on 1/22/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum DetailType : NSUInteger {
    EditOnly,
    EditAndSave,
    None
} DetailType;

@interface BBAppState : NSObject

@property (nonatomic,strong) NSArray* typeName;
@property (nonatomic, strong) PFUser *user;

+ (BBAppState*)getInstance;


@end
