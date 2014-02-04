//
//  BBNote.h
//  BowlingBag
//
//  Created by Won Kim on 2/4/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBNote : NSObject


@property (nonatomic,strong)    NSString* objectID;
@property (nonatomic,strong)    NSString* title;
@property (nonatomic,strong)    NSString* note;


-(id)initWithPFObject:(PFObject*)object;
-(NSArray *)parseNote:(NSArray *)array;

-(void)save;
-(void)update;
-(void)deleteObject;
@end
