//
//  BBRegisterViewController.m
//  BowlingBag
//
//  Created by won kim on 1/20/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBRegisterViewController.h"

@interface BBRegisterViewController ()

@end

@implementation BBRegisterViewController

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


#pragma mark- Button Action
- (IBAction)pressRegister:(id)sender {
    
    [self performSegueWithIdentifier:@"HomeSegue"sender:self];
}

@end
