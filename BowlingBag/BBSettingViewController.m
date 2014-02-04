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
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"BackHomeSegue" sender:nil];
    
}


@end
