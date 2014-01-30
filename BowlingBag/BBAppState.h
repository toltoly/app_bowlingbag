//
//  BBAppState.h
//  BowlingBag
//
//  Created by Won Kim on 1/22/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBAppState : NSObject

@property (nonatomic,strong) NSArray* typeName;
@property (nonatomic, strong) PFUser *user;

+ (BBAppState*)getInstance;


@end
