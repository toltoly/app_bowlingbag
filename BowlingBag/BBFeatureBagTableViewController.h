//
//  BBFeatureBagTableViewController.h
//  BowlingBag
//
//  Created by Won Kim on 2/3/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBFeatureBagTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *bowlArray;
@end
