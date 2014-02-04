//
//  BBNoteTableViewController.h
//  BowlingBag
//
//  Created by won kim on 1/26/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBNoteTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *noteArray;

@end
