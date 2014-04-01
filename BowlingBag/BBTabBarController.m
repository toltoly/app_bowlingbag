//
//  BBTabBarController.m
//  BowlingBag
//
//  Created by won kim on 3/28/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBTabBarController.h"

@interface BBTabBarController ()

@end

@implementation BBTabBarController

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
    
    UITabBar *tabBar = self.tabBar;
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:195.0/255.0 green:0.0/255.0 blue:43.0/255.0 alpha:1]];
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"bag_on_tb"] withFinishedUnselectedImage:[UIImage imageNamed:@"bag_off_tb"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"note_on_tb"] withFinishedUnselectedImage:[UIImage imageNamed:@"note_off_tb"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"featured_on_tb"] withFinishedUnselectedImage:[UIImage imageNamed:@"featured_off_tb"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"settings_on_tb"] withFinishedUnselectedImage:[UIImage imageNamed:@"settings_off_tb"]];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
