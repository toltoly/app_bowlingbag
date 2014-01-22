//
//  BBowlAddViewController.h
//  BowlingBag
//
//  Created by won kim on 1/21/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "BBPopoverMenuViewController.h"
@interface BBowlAddViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>



@property (nonatomic, strong) BBPopoverMenuViewController *menuPicker;
@property (nonatomic, strong) UIPopoverController         *menuPickerPopover;


@end
