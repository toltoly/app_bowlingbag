//
//  BBNoteTableViewController.m
//  BowlingBag
//
//  Created by won kim on 1/26/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBNoteTableViewController.h"
#import "BBNoteDetailViewController.h"
#import "BBNote.h"
#import "BBBowlCell.h"
@interface BBNoteTableViewController ()
{
    
    IBOutlet UITableView *noteTableView;
    

    
    BBAppState* appState;

    BBNote* selNote;
}


@end

@implementation BBNoteTableViewController

@synthesize noteArray;

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
    
    appState=[BBAppState getInstance];
    

    noteArray=[NSMutableArray array];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   //  self.navigationController.navigationBar.topItem.title=@"Notes";
    [self retrieveData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark Button Action


- (IBAction)pressLogout:(id)sender {
    
    [PFUser logOut];
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
        
        
        [vc setDetailViewType:EditOnly];
        [vc setNote:[[BBNote alloc]init]];
    }
    else if([[segue identifier] isEqualToString:@"NoteDetailSegue"])
    {
     //   self.navigationController.navigationBar.topItem.title=selNote.title;
        BBNoteDetailViewController *vc = [segue destinationViewController];
        
        [vc setDetailViewType:EditAndSave];
        [vc setNote:selNote];
    }
  
    
}


#pragma -mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return noteArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BBBowlCell* cell = (BBBowlCell *)[tableView dequeueReusableCellWithIdentifier:@"kNoteCell"];
    BBNote* bowl=noteArray[indexPath.row];
    NSLog(@" tableView %@",bowl);
    cell.name.text= bowl.title;
  //  [cell.thumbImage setImageWithURL: [NSURL URLWithString:bowl.thumbnail.url] placeholderImage:[UIImage imageNamed:@"camera_icon.png"]];
    
    return cell;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 80;
    return 51;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selNote=noteArray[indexPath.row];
    
    [self performSegueWithIdentifier:@"NoteDetailSegue" sender:nil];
    
}




#pragma mark PARSE
-(void)retrieveData
{
    
    PFQuery *queryBowl = [PFQuery queryWithClassName:kNoteClassKey];
    [queryBowl whereKey:kNoteUserKey equalTo:[PFUser currentUser]];
    [queryBowl setCachePolicy:kPFCachePolicyCacheThenNetwork];
    [queryBowl findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
        if (!error)
        {
            // The find succeeded.
            [noteArray removeAllObjects];
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects)
            {
                
                BBNote* bowl=[[BBNote alloc]initWithPFObject:object];

                    
                NSLog(@" retrieveData %@",bowl);
                [noteArray addObject:bowl];
                
                
                
            }
            [noteTableView reloadData];
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
}


@end
