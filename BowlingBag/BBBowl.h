//
//  BBBowl.h
//  BowlingBag
//
//  Created by Won Kim on 1/30/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBBowl : NSObject
{
  
}

@property (nonatomic,strong)    NSString* name;
@property (nonatomic,strong)    NSString* type;
@property (nonatomic,strong)    NSString* note;
@property (nonatomic,strong)    NSString* image;
@property (nonatomic,strong)    NSString* thumbnail;
@property (nonatomic)           BOOL featured;


-(id)initWithPFObject:(PFObject*)object;
-(int)getTypeInt;
-(void)setTypeInt:(int)i;

-(NSArray *)parseBowl:(NSArray *)array;



@end
