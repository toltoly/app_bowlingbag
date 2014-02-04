//
//  BBNoteDetailViewController.h
//  BowlingBag
//
//  Created by won kim on 1/27/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBNote.h"
@interface BBNoteDetailViewController : UIViewController<UITextViewDelegate>



@property (nonatomic, strong)BBNote* note;

@property (nonatomic)  DetailType detailViewType;

@end
