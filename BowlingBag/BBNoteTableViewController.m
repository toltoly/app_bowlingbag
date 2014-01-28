//
//  BBNoteTableViewController.m
//  BowlingBag
//
//  Created by won kim on 1/26/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBNoteTableViewController.h"
#import "BBNoteDetailViewController.h"

@interface BBNoteTableViewController ()
{
    
    IBOutlet UITableView *noteTableView;
    
   
}

@end

@implementation BBNoteTableViewController

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


#pragma -mark Button Action
- (IBAction)pressLogout:(id)sender {
    
    [self performSegueWithIdentifier:@"BackHomeSegue" sender:nil];
    //   [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)pressAddBowl:(id)sender {
    [self performSegueWithIdentifier:@"AddNoteSegue" sender:nil];
    
}

#pragma  -mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"AddNoteSegue"]  )
    {
        // Get reference to the destination view controller
        BBNoteDetailViewController *vc = [segue destinationViewController];
        
        [vc setOnlyEditMode:TRUE];
    }
    else if([[segue identifier] isEqualToString:@"NoteDetailSegue"])
    {
        BBNoteDetailViewController *vc = [segue destinationViewController];
        [vc setOnlyEditMode:FALSE];
    }
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
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"kNoteCell"];
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self performSegueWithIdentifier:@"NoteDetailSegue" sender:nil];
    
}

@end
