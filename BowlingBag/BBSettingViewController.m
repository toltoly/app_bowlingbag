//
//  BBSettingViewController.m
//  BowlingBag
//
//  Created by Won Kim on 2/4/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBSettingViewController.h"

@interface BBSettingViewController ()

@end

@implementation BBSettingViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Button

- (IBAction)pressLogout:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are  you sure?"  delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alertView setTag:0];
    [alertView show];
    

    
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  {
    

    
    switch (alertView.tag) {
        case 0:
            if (buttonIndex == 0)   {
                // do nothing
            }
            else {
                [PFUser logOut];
                [self performSegueWithIdentifier:@"BackHomeSegue" sender:nil];

            }
            break;
            
        case 1:
            if (buttonIndex == 0)   {
                // do nothing
            }
            else        {

            }
            break;
            
        case 2:
            if (buttonIndex == 0)   {
                // do nothing
            }
            else        {

            }
            
            
        default:
            break;
    }
    
}

@end
