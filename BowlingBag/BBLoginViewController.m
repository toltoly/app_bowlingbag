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
{
    IBOutlet UITextField *emailTextField;
    
    IBOutlet UITextField *passwordTextField;
    
    UITapGestureRecognizer  *tapRecognizer;
}

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
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
    
    
    //Notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];

    
 
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // If we have a cached user, we'll get it back here
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser)
    {
        [self performSegueWithIdentifier:@"HomeSegue"sender:self];
    }
    else
    {
        
    }
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
    
    
    [self.view removeGestureRecognizer:tapRecognizer];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [emailTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];

}

    
    


#pragma -mark Button Action

- (IBAction)pressLogin:(id)sender {
    
  /*  PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];*/
    
    if(emailTextField.text.length==0 || passwordTextField.text.length==0)
    {
        //show alert message
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Couldn't log in:" message:@"Please enter valid email and password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [warningAlert show];
    }
    else
    {
        if([self validateEmail:emailTextField.text])
        {


            [PFUser logInWithUsernameInBackground: emailTextField.text
                                         password:passwordTextField.text
                                            block:^(PFUser *user, NSError *error)
             {
                 if (user) // Login successful
                 {
                      [self performSegueWithIdentifier:@"HomeSegue"sender:self];
    
                 }
                 else // Login failed
                 {
                     UIAlertView *alertView = nil;
                     
                     if (error == nil) // Login failed because of an invalid username and password
                     {
                         // Create an alert view to tell the user
                         alertView = [[UIAlertView alloc] initWithTitle:@"Couldn't log in:"
                                      "\nThe username or password were wrong."
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Ok", nil];
                     }
                     else // Login failed for another reason
                     {
                         // Create an alert view to tell the user
                         alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"]
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Ok", nil];
                     }
                     // Show the alert view
                     [alertView show];
                     
                     // Bring the keyboard back up, user will probably need to change something
                     [emailTextField becomeFirstResponder];
                 }
             }];
            
           
            
        }
        else
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Couldn't log in:" message:@"Please enter valid email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [warningAlert show];
            
        }
    }
    
    
    
   
}

- (IBAction)pressForgotPassword:(id)sender {
}

#pragma mark- Helper function
-(BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; //  return 0;
    return [emailTest evaluateWithObject:candidate];
}
@end
