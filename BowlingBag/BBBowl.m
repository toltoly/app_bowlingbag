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

@synthesize  name,type,note,image,thumbnail,featured,objectID,bagtype;


-(id)initWithPFObject:(PFObject*)object
{
    if (self = [super init]) {
       
        state=[BBAppState getInstance];
        self.name=object[kBagNameKey];
     //   self.type=object[kBagTypeKey];
        self.note=object[kBagNoteKey];
        self.image=object[kBagImageKey];
        self.thumbnail=object[kBagThumbnailKey];
        self.featured=[object[kBagFeaturedKey] boolValue];
        self.bagtype=[object[kBagTypeKey] integerValue];
        self.objectID=object.objectId;
        
        
        
    }
    return self;
    
}

- (NSString *)description {
    NSString *descriptionString = [NSString stringWithFormat:@"Name: %@ \n type: %lu \n image:%@", self.name, (unsigned long)self.bagtype,self.image.url];
    return descriptionString;
    
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

-(void)save
{
    
    PFObject *newBowl = [PFObject objectWithClassName:kBagClassKey];
    [newBowl setObject:name forKey:kBagNameKey];
//    [newBowl setObject:type forKey:kBagTypeKey];
    [newBowl setObject:[NSNumber numberWithInteger:bagtype]  forKey:kBagTypeKey];
    [newBowl setObject:note forKey:kBagNoteKey];
    
    if(image)
    {
        [newBowl setObject:image forKey:kBagImageKey];
        [newBowl setObject:thumbnail forKey:kBagThumbnailKey];
    }
    [newBowl setObject:[NSNumber numberWithBool:NO]  forKey:kBagFeaturedKey];
    [newBowl setObject:[PFUser currentUser] forKey:kBagUserKey];
    
    
    // Save the Photo PFObject
    [newBowl saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
  
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't add your bowl" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
            [alert show];
        }
       
    }];

    
}
-(void)update
{
    PFQuery *queryBowl = [PFQuery queryWithClassName:kBagClassKey];
    [queryBowl whereKey:kBagUserKey equalTo:[PFUser currentUser]];
    
    // Retrieve the object by id
    [queryBowl getObjectInBackgroundWithId:objectID block:^(PFObject *bowl, NSError *error) {

        bowl[kBagNameKey]=self.name;
        bowl[kBagTypeKey]=[NSNumber numberWithInteger:bagtype];
        bowl[kBagNoteKey]=self.note;
        if( self.image)
        {
            bowl[kBagImageKey]=self.image;
            bowl[kBagThumbnailKey]=self.thumbnail;
        }
        bowl[kBagFeaturedKey]=[NSNumber numberWithBool:NO];
      
        [bowl saveInBackground];
        
    }];
    
}

-(void)deleteObject
{
    PFQuery *queryBowl = [PFQuery queryWithClassName:kBagClassKey];
    [queryBowl whereKey:kBagUserKey equalTo:[PFUser currentUser]];
    
    // Retrieve the object by id
    [queryBowl getObjectInBackgroundWithId:objectID block:^(PFObject *bowl, NSError *error) {
        

        
        [bowl deleteInBackground];
        
    }];

}
@end
