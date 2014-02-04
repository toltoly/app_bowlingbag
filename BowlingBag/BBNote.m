//
//  BBNote.m
//  BowlingBag
//
//  Created by Won Kim on 2/4/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBNote.h"
#import "BBAppState.h"

@interface BBNote()
{
    BBAppState* state;
}
@end

@implementation BBNote

@synthesize title,note,objectID;


-(id)initWithPFObject:(PFObject*)object
{
    if (self = [super init]) {
        
        state=[BBAppState getInstance];
        self.title=object[kNoteTitleKey];
        self.note=object[kNoteNoteKey];
        self.objectID=object.objectId;
        
    }
    return self;
    
}
- (NSString *)description {
    NSString *descriptionString = [NSString stringWithFormat:@"title: %@ \n  note:%@", self.title, self.note];
    return descriptionString;
    
}



-(NSArray *)parseNote:(NSArray *)array
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for(PFObject* object in array)
    {
        BBNote* notes=[[BBNote alloc]initWithPFObject:object];
        [results addObject:notes];
    }
    
    return [results copy];
    
}

-(void)save
{
    
    PFObject *newBowl = [PFObject objectWithClassName:kNoteClassKey];
    [newBowl setObject:title forKey:kNoteTitleKey];
    [newBowl setObject:note forKey:kNoteNoteKey];
    [newBowl setObject:[PFUser currentUser] forKey:kNoteUserKey];
    
    // Save the Photo PFObject
    [newBowl saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't add your note" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
            [alert show];
        }
        
    }];
    
    
}
-(void)update
{
    PFQuery *queryBowl = [PFQuery queryWithClassName:kNoteClassKey];
    [queryBowl whereKey:kNoteUserKey equalTo:[PFUser currentUser]];
    
    // Retrieve the object by id
    [queryBowl getObjectInBackgroundWithId:objectID block:^(PFObject *bowl, NSError *error) {
        
        bowl[kNoteTitleKey]=self.title;
        bowl[kNoteNoteKey]=self.note;
        [bowl saveInBackground];
        
    }];
    
}

-(void)deleteObject
{
    PFQuery *queryBowl = [PFQuery queryWithClassName:kNoteClassKey];
    [queryBowl whereKey:kNoteUserKey equalTo:[PFUser currentUser]];
    
    // Retrieve the object by id
    [queryBowl getObjectInBackgroundWithId:objectID block:^(PFObject *bowl, NSError *error) {
        
    [bowl deleteInBackground];
        
    }];
    
}
@end
