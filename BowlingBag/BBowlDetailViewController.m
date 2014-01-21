//
//  BBowlDetailViewController.m
//  BowlingBag
//
//  Created by Won Kim on 1/21/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBowlDetailViewController.h"

@interface BBowlDetailViewController ()
{
    IBOutlet UIImageView *imageView;
    
    IBOutlet UITextView *ballTypeTextView;
    IBOutlet UITextView *descriptionBallTextView;
 
}

@end

@implementation BBowlDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightbutton setTitle:@"Edit" forState:UIControlStateNormal];
   // [rightbutton setTitleColor:kLightBlueColor forState:UIControlStateNormal ];
    [rightbutton addTarget:self action:@selector(pressEdit) forControlEvents:UIControlEventTouchUpInside];
    rightbutton.frame=CGRectMake(50,50,50,50);
    
    UIBarButtonItem *customrightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem=customrightBarItem;
 //   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"White"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEditMode:(BOOL)editmode
{
    ballTypeTextView.selectable=editmode;
    ballTypeTextView.editable=editmode;
    
    descriptionBallTextView.selectable=editmode;
    descriptionBallTextView.editable=editmode;
    
    
}

#pragma -mark Button Action

-(void)pressEdit
{
    
     // [self performSegueWithIdentifier:@"EditBowlSegue" sender:nil];
    
    //Edit mode
    
    
}
- (IBAction)pressPictureEdit:(UIButton*)sender {
    
 /*   if (_menuPickerPopover == nil) {
        
        
        if (_menuPicker == nil) {
            //Create the ColorPickerViewController.
            _menuPicker = [[BBPopoverMenuViewController alloc] initWithStyle:UITableViewStylePlain];
            
            //Set this VC as the delegate.
            _menuPicker.delegate = self;
        }
        
        _menuPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_menuPicker];
        
    }
    
    if(_menuPickerPopover.popoverVisible)
    {
        [_menuPickerPopover dismissPopoverAnimated:YES];
        _menuPickerPopover=nil;
    }
    else
        [_menuPickerPopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
*/
    
}



#pragma mark - Popover methods
-(void)menuItemSelected:(int)menuItem   {
    
    //Dismiss the popover if it's showing.
    if (_menuPickerPopover) {
        [_menuPickerPopover dismissPopoverAnimated:YES];
        _menuPickerPopover = nil;
        //   _menuPicker=nil;
    }
    
}

@end
