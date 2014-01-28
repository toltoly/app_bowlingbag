//
//  BBNoteDetailViewController.m
//  BowlingBag
//
//  Created by won kim on 1/27/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBNoteDetailViewController.h"

#define  kViewDetailMoveDistance 100

@interface BBNoteDetailViewController ()
{
     UITapGestureRecognizer  *tapRecognizer;
    
    IBOutlet UIView *noteDetailView;
    
    IBOutlet UIImageView *noteHeaderImage;
    IBOutlet UITextField *noteHeaderTextField;
    IBOutlet UILabel *noteHeaderLabel;
    
    IBOutlet UIImageView *noteTextImage;
    IBOutlet UITextView *noteTextview;
    
}

@end

@implementation BBNoteDetailViewController

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
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
    
    
    //Notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    
     [self setEditMode:FALSE];

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

    
}

-(void)setEditMode:(BOOL)editmode
{
    
    
    noteTextview.selectable=editmode;
    noteTextview.editable=editmode;

    noteHeaderLabel.hidden=editmode;
    noteHeaderTextField.hidden=!editmode;
    
    if(editmode)
    {
        [noteHeaderImage setImage:[UIImage imageNamed:@"edit_box.png"]];
        [noteTextImage setImage:[UIImage imageNamed:@"edit_box.png"]];

    }
    else
    {
        [noteHeaderImage setImage:[UIImage imageNamed:@"text_box.png"]];
        [noteTextImage setImage:[UIImage imageNamed:@"text_box.png"]];

        
    }

    if(editmode)
    {
        UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        [rightbutton setTitle:@"Save" forState:UIControlStateNormal];
        // [rightbutton setTitleColor:kLightBlueColor forState:UIControlStateNormal ];
        [rightbutton addTarget:self action:@selector(pressSave) forControlEvents:UIControlEventTouchUpInside];
        rightbutton.frame=CGRectMake(50,50,50,50);
        
        UIBarButtonItem *customrightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
        self.navigationItem.rightBarButtonItem=customrightBarItem;
        //   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"White"] forBarMetrics:UIBarMetricsDefault];
        
        
    }
    else
    {
        UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        [rightbutton setTitle:@"Edit" forState:UIControlStateNormal];
        // [rightbutton setTitleColor:kLightBlueColor forState:UIControlStateNormal ];
        [rightbutton addTarget:self action:@selector(pressEdit) forControlEvents:UIControlEventTouchUpInside];
        rightbutton.frame=CGRectMake(50,50,50,50);
        
        UIBarButtonItem *customrightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
        self.navigationItem.rightBarButtonItem=customrightBarItem;
        
    }
    
    
}


-(void)pressEdit
{

    
    //Edit mode
    
    [self setEditMode:TRUE];
    
}
-(void)pressSave
{
    

    
    //Edit mode
    
    [self setEditMode:FALSE];
    
}

#pragma  -mark TextView delegate

-(void)textViewDidChange:(UITextView *)textView
{
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldBeginEditing : %d",textView.tag);
    
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
