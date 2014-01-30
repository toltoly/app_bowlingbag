//
//  BBBowl.m
//  BowlingBag
//
//  Created by Won Kim on 1/30/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBBowl.h"
#import "BBAppState.h"

@interface BBBowl()
{
    BBAppState* state;
}
@end

@implementation BBBowl

@synthesize  name,type,note,image,thumbnail,featured;


-(id)initWithPFObject:(PFObject*)object
{
    if (self = [super init]) {
       
        state=[BBAppState getInstance];
        self.name=object[kBagNameKey];
        self.type=object[kBagTypeKey];
        self.note=object[kBagNoteKey];
        self.image=object[kBagImageKey];
        self.thumbnail=object[kBagThumbnailKey];
        self.featured=[object[kBagFeaturedKey] boolValue];
        
        
    }
    return self;
    
}

-(int)getTypeInt
{
    
    
    for(int i=0;i<state.typeName.count;i++)
    {
        if([self.type isEqualToString: state.typeName[i]])
        {
            return i;
        }
    }
   

    return 0;
    
}
-(void)setTypeInt:(int)i
{
    self.type=state.typeName[i];
}


-(NSArray *)parseBowl:(NSArray *)array
{
     NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for(PFObject* object in array)
    {
        BBBowl* bowl=[[BBBowl alloc]initWithPFObject:object];
        [results addObject:bowl];
    }
    
    
     return [results copy];
    
}

@end
