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


#pragma -mark Button Action

-(void)pressEdit
{
    
      [self performSegueWithIdentifier:@"EditBowlSegue" sender:nil];
}
@end
