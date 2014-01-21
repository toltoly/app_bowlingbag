//
//  BBPopoverMenuViewController.h
//  BowlingBag
//
//  Created by Won Kim on 1/21/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBPopoverMenuViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *menuItems;
@property (nonatomic, weak) id delegate;




@end


@protocol RDPopoverMenuDelegate <NSObject>

-(void)menuItemSelected:(int)menuItem;

@end