//
//  BBagTableViewController.m
//  BowlingBag
//
//  Created by Won Kim on 1/21/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBagTableViewController.h"
#import "BBowlDetailViewController.h"
#import <Parse/Parse.h>
#import "BBBowl.h"
@interface BBagTableViewController ()
{
    
    IBOutlet UITableView *bagTableView;
    IBOutlet UISegmentedControl *segumentControler;
    
    int curBagType;
    BBAppState* appState;
    BBBowl* selBowl;
}

@end

@implementation BBagTableViewController

@synthesize bowlArray;

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
    
    appState=[BBAppState getInstance];
 
   // bowlArray= @[ @"Blue", @"Red", @"Green" ];
    bowlArray=[NSMutableArray array];
    
    segumentControler.selectedSegmentIndex=0;
    curBagType=0;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self retrieveData];
    
}


#pragma -mark Button Action
-(IBAction)changeViewSegue
{
    if(curBagType==segumentControler.selectedSegmentIndex)
        return;
    
    curBagType=segumentControler.selectedSegmentIndex;
    
    if(segumentControler.selectedSegmentIndex == 0)
    {
        
        [self retrieveData];
        
        
    }
    else if(segumentControler.selectedSegmentIndex == 1)
    {
         [self retrieveData];
        
    }
    else if(segumentControler.selectedSegmentIndex == 2)
    {
        
        [self retrieveData];
        
    }
    else if(segumentControler.selectedSegmentIndex == 3)
    {
        
         [self retrieveData];
    }
    
}

- (IBAction)pressLogout:(id)sender {
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"BackHomeSegue" sender:nil];
 //   [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)pressAddBowl:(id)sender {
     [self performSegueWithIdentifier:@"AddBowlSegue" sender:nil];
    
}


#pragma  -mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"AddBowlSegue"]  )
    {
        // Get reference to the destination view controller
        BBowlDetailViewController *vc = [segue destinationViewController];

        [vc setOnlyEditMode:TRUE];
        [vc setBowl:[[BBBowl alloc]init]];
    }
    else if([[segue identifier] isEqualToString:@"BowlDetailSegue"])
    {
         BBowlDetailViewController *vc = [segue destinationViewController];
        [vc setOnlyEditMode:FALSE];
        [vc setBowl:selBowl];
    }
}


#pragma -mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return bowlArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"kBowlCell"];
    
    BBBowl* bowl=bowlArray[indexPath.row];
    cell.textLabel.text=bowl.name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selBowl=bowlArray[indexPath.row];

    [self performSegueWithIdentifier:@"BowlDetailSegue" sender:nil];
    
}


#pragma mark PARSE
-(void)retrieveData
{
    
    [bowlArray removeAllObjects];
    PFQuery *queryBowl = [PFQuery queryWithClassName:kBagClassKey];
    [queryBowl whereKey:kBagUserKey equalTo:appState.user];
    [queryBowl whereKey:kBagTypeKey equalTo:appState.typeName[curBagType]];
    [queryBowl setCachePolicy:kPFCachePolicyCacheThenNetwork];
    [queryBowl findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);

                BBBowl* bowl=[[BBBowl alloc]initWithPFObject:object];
                [bowlArray addObject:bowl];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    [bagTableView reloadData];
    
}

@end
