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
@interface BBowlDetailViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>



@property (nonatomic, strong) BBPopoverMenuViewController *menuPicker;
@property (nonatomic, strong) UIPopoverController         *menuPickerPopover;




@end
