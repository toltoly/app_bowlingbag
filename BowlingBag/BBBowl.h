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

@property (nonatomic,strong)    NSString* objectID;
@property (nonatomic,strong)    NSString* name;
@property (nonatomic,strong)    NSString* type;
@property (nonatomic,strong)    NSString* note;
@property (nonatomic,strong)    PFFile* image;
@property (nonatomic,strong)    PFFile* thumbnail;
@property (nonatomic)           BOOL featured;



-(id)initWithPFObject:(PFObject*)object;
-(int)getTypeInt;
-(void)setTypeInt:(int)i;

-(NSArray *)parseBowl:(NSArray *)array;

-(void)save;
-(void)update;
-(void)deleteObject;
@end
