//
//  BBNoteDetailViewController.m
//  BowlingBag
//
//  Created by won kim on 1/27/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBNoteDetailViewController.h"

#define  kViewDetailMoveDistance 40

@interface BBNoteDetailViewController ()
{
     UITapGestureRecognizer  *tapRecognizer;
    
    IBOutlet UIView *noteDetailView;
    
    IBOutlet UIImageView *noteHeaderImage;
    IBOutlet UITextField *noteHeaderTextField;
    IBOutlet UILabel *noteHeaderLabel;
    
    IBOutlet UIImageView *noteTextImage;
    IBOutlet UITextView *noteTextview;
    
    IBOutlet UIButton *deleteNoteButton;
    
    BOOL isInEditMode;
    IBOutlet UIButton *sharedButton;
}

@end

@implementation BBNoteDetailViewController


@synthesize detailViewType,note;
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
    self.navigationController.navigationBar.translucent=NO;
	// Do any additional setup after loading the view.
    //
    //    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [rightbutton setTitle:@"Edit" forState:UIControlStateNormal];
    //   // [rightbutton setTitleColor:kLightBlueColor forState:UIControlStateNormal ];
    //    [rightbutton addTarget:self action:@selector(pressEdit) forControlEvents:UIControlEventTouchUpInside];
    //    rightbutton.frame=CGRectMake(50,50,50,50);
    //
    //    UIBarButtonItem *customrightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    //    self.navigationItem.rightBarButtonItem=customrightBarItem;
    // //   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"White"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0,0,28,28);
    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [button addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
    
    
    //Notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    
    isInEditMode=FALSE;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
    
    if(detailViewType==EditOnly)
    {

        deleteNoteButton.hidden=TRUE;
        [self setEditMode:TRUE];
    }
    else if(detailViewType==EditAndSave)
    {
         deleteNoteButton.hidden=TRUE;
        [self setEditMode:isInEditMode];
    }
    else
    {
        deleteNoteButton.hidden=TRUE;
        [self setEditMode:FALSE];
    }
    
    [self fillView];
}


-(void)fillView
{
   
    noteHeaderLabel.text=note.title;
    noteTextview.text=note.note;
    
}
-(void)saveNote
{
    note.title=noteHeaderTextField.text;
    note.note=noteTextview.text;
    
    [note save];
    
    
}
-(void)updateNote
{
    note.title=noteHeaderTextField.text;
 //    self.navigationController.navigationBar.topItem.title=note.title;
    noteHeaderLabel.text=noteHeaderTextField.text;
    note.note=noteTextview.text;
    //   bowl.type=typeButton1.titleLabel.text;
    // create a photo object
    
    [note update];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  -mark keypad visible Notification

-(void) keyboardWillShow:(NSNotification *) note {
    
    [self.view addGestureRecognizer:tapRecognizer];
    
    
}

-(void) keyboardWillHide:(NSNotification *) note
{
    
    if(noteDetailView.frame.origin.y==-kViewDetailMoveDistance)
    {
        [self moveView:noteDetailView From:-kViewDetailMoveDistance Distance:kViewDetailMoveDistance Speed:0.5 AxisX:FALSE];
    }


    
    [self.view removeGestureRecognizer:tapRecognizer];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {

    [noteHeaderTextField resignFirstResponder];
    
    [noteTextview resignFirstResponder];
}

-(void)setEditMode:(BOOL)editmode
{
    
    
    noteTextview.selectable=editmode;
    noteTextview.editable=editmode;

    noteHeaderLabel.hidden=editmode;
    noteHeaderTextField.hidden=!editmode;
    
    if(editmode)
    {
        if(detailViewType==EditAndSave)
            deleteNoteButton.hidden=FALSE;
        
        sharedButton.hidden=TRUE;
        noteHeaderImage.hidden=FALSE;
        noteTextImage.hidden=FALSE;
      

    }
    else
    {
        if(detailViewType==EditAndSave)
            deleteNoteButton.hidden=TRUE;
        sharedButton.hidden=FALSE;
        noteHeaderImage.hidden=TRUE;
        noteTextImage.hidden=TRUE;


        
    }

    if(editmode)
    {
        UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        rightbutton.frame = CGRectMake(0,0,28,28);
        [rightbutton setBackgroundImage:[UIImage imageNamed:@"Save_hollow"] forState:UIControlStateNormal];
        // [rightbutton setTitleColor:kLightBlueColor forState:UIControlStateNormal ];
        [rightbutton addTarget:self action:@selector(pressSave) forControlEvents:UIControlEventTouchUpInside];
      //  rightbutton.frame=CGRectMake(50,50,50,50);
        
        UIBarButtonItem *customrightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
        self.navigationItem.rightBarButtonItem=customrightBarItem;
        //   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"White"] forBarMetrics:UIBarMetricsDefault];
        
        
    }
    else
    {
        UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        rightbutton.frame = CGRectMake(0,0,28,28);
        [rightbutton setBackgroundImage:[UIImage imageNamed:@"Edit_hollow"] forState:UIControlStateNormal];
        // [rightbutton setTitleColor:kLightBlueColor forState:UIControlStateNormal ];
        [rightbutton addTarget:self action:@selector(pressEdit) forControlEvents:UIControlEventTouchUpInside];
      //  rightbutton.frame=CGRectMake(50,50,50,50);
        
        UIBarButtonItem *customrightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
        self.navigationItem.rightBarButtonItem=customrightBarItem;
        
    }
    
    
}


-(void)pressEdit
{

    
    //Edit mode
    
    noteHeaderTextField.text=noteHeaderLabel.text;
    [self setEditMode:TRUE];
    
}
-(void)pressSave
{
    
    [self didTapAnywhere:nil];
    
    if(detailViewType==EditOnly)
    {
        //go back to table
        [self saveNote];
        [self. navigationController popViewControllerAnimated:TRUE];
        
    }
    else
    {
        [self updateNote];
        [self setEditMode:FALSE];
        
    }

    
}

#pragma  makr button Action

- (IBAction)pressDeleteNote:(id)sender {
    
    [note deleteObject];
    [self.navigationController popViewControllerAnimated:TRUE];
    
}

- (IBAction)pressSharedButton:(id)sender {
    
    //
    //    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
    //                                   @"Sharing Tutorial", @"name",
    //                                   @"Build great social apps and get more installs.", @"caption",
    //                                   @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
    //                                   @"https://developers.facebook.com/docs/ios/share/", @"link",
    //                                   @"http://i.imgur.com/g3Qc1HN.png", @"picture",
    //                                   nil];
    //
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(screenWidth/2, screenHeight/2);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    // Put together the dialog parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   note.title, @"name",
                                   @"----", @"caption",
                                   note.note, @"description",
                                   @"http://files.parse.com/ad1acf14-0d33-4694-abc5-071bb9781943/bee98806-54d8-467b-9a3f-6f47b2da9c85-bowlingball256.png", @"picture",
                                   nil];
    
    // Make the request
    [FBRequestConnection startWithGraphPath:@"/me/feed"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  [spinner stopAnimating];
                                  // Link posted successfully to Facebook
                                  NSLog(@"result: %@", result);
                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result" message:@"Success!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                  [alert show];
                                  
                              } else {
                                  [spinner stopAnimating];
                                  // An error occurred, we need to handle the error
                                  // See: https://developers.facebook.com/docs/ios/errors
                                  NSLog(@"%@", error.description);
                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                  [alert show];
                              }
                          }];
}


#pragma  -mark TextView delegate

-(void)textViewDidChange:(UITextView *)textView
{
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldBeginEditing : %ld",(long)textView.tag);
    
    if(textView.tag==1)
    {
        //move view to up
        [self moveView:noteDetailView From:0 Distance:-kViewDetailMoveDistance Speed:0.5 AxisX:FALSE];
    }
    return TRUE;
}

#pragma mark - transition functions
-(void)moveView:(id)aView From:(float)from Distance:(float)dist Speed:(float)speed AxisX:(BOOL)axisX
{
    if(![aView isKindOfClass:[UIView class]])
        return;
    
    UIView* view=(UIView*)aView;
    
    CGRect frame=view.frame;
    if(axisX)
    {
        frame.origin.x=from;
        view.frame=frame;
        frame.origin.x=from+dist;
    }
    else
    {
        frame.origin.y=from;
        view.frame=frame;
        frame.origin.y=from+dist;
    }
    
    [UIView animateWithDuration:speed animations:^{
        view.frame = frame;
    }];
    
}



@end
