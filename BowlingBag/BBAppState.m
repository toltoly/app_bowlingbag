//
//  BBAppState.m
//  BowlingBag
//
//  Created by Won Kim on 1/22/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBAppState.h"

@implementation BBAppState

static BBAppState *sharedInstance;

+ (BBAppState*)getInstance {
	
	@synchronized(self) {
		if(!sharedInstance) {
			
            sharedInstance = [[BBAppState alloc] init];
            
		}
	}
	
	return sharedInstance;
}

- (id)init{
    self = [super init];
    if(self){
        
         _typeName=@[@"Arsenal",@"League",@"Tournament",@"Sport Shot"];

	}
    return self;
}


@end
