//
//  BBLoginViewController.m
//  BowlingBag
//
//  Created by won kim on 1/20/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBLoginViewController.h"
#import <Parse/Parse.h>
@interface BBLoginViewController ()

@end

@implementation BBLoginViewController

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
    
  //  [self performSegueWithIdentifier:@"HomeSegue"sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma -mark Button Action

- (IBAction)pressLogin:(id)sender {
    
  /*  PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];*/
    
    [self performSegueWithIdentifier:@"HomeSegue"sender:self];
}


@end
