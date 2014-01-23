//
//  BBagTableViewController.m
//  BowlingBag
//
//  Created by Won Kim on 1/21/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBagTableViewController.h"

@interface BBagTableViewController ()
{
    
    IBOutlet UITableView *bagTableView;
}

@end

@implementation BBagTableViewController

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
    self.navigationController.navigationBar.translucent=NO;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma -mark Button Action
- (IBAction)pressLogout:(id)sender {
    
 //   [self performSegueWithIdentifier:@"BackHomeSegue" sender:nil];
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)pressAddBowl:(id)sender {
     [self performSegueWithIdentifier:@"AddBowlSegue" sender:nil];
    
}


#pragma -mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"kBowlCell"];
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    [self performSegueWithIdentifier:@"BowlDetailSegue" sender:nil];
    
}


@end
