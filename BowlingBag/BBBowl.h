//
//  BBBowl.h
//  BowlingBag
//
//  Created by Won Kim on 1/30/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSUInteger BAG_TYPE;

enum
{
    ARSENAL             = 1 << 0,
    LEAGUE              = 1 << 1,
    TOURNAMENT          = 1 << 2,
    SPORT_SHOT          = 1 << 3,
};



@interface BBBowl : NSObject
{
  
}

@property (nonatomic,strong)    NSString* objectID;
@property (nonatomic,strong)    NSString* name;
@property (nonatomic,strong)    NSString* type;
@property (nonatomic,strong)    NSString* note;
@property (nonatomic,strong)    PFFile* image;
@property (nonatomic,strong)    PFFile* thumbnail;
@property (nonatomic)           BOOL featured;
@property (nonatomic)           BAG_TYPE bagtype;


-(id)initWithPFObject:(PFObject*)object;
-(int)getTypeInt;
-(void)setTypeInt:(int)i;

-(NSArray *)parseBowl:(NSArray *)array;

-(void)save;
-(void)update;
-(void)deleteObject;
@end
