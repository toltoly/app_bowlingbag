//
//  BBowlDetailViewController.h
//  BowlingBag
//
//  Created by Won Kim on 1/21/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "BBPopoverMenuViewController.h"
#import "BBBowl.h"

typedef enum DetailType : NSUInteger {
    EditOnly,
    EditAndSave,
    None
} DetailType;

@interface BBowlDetailViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>



@property (nonatomic, strong) BBPopoverMenuViewController *menuPicker;
@property (nonatomic, strong) UIPopoverController         *menuPickerPopover;


@property (nonatomic, strong)BBBowl* bowl;

@property (nonatomic)  DetailType detailViewType;
@end
