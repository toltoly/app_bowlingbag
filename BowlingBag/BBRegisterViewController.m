//
//  BBRegisterViewController.m
//  BowlingBag
//
//  Created by won kim on 1/20/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBRegisterViewController.h"
#import <Parse/Parse.h>
@interface BBRegisterViewController ()
{
    IBOutlet UITextField *emailTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UITextField *confirmPasswordTextField;
    
    UITapGestureRecognizer  *tapRecognizer;

}

@end

@implementation BBRegisterViewController

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
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
    
    
    //Notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];

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
     [confirmPasswordTextField resignFirstResponder];

    
    
}
#pragma mark- Button Action
- (IBAction)pressRegister:(id)sender {
    
    if(emailTextField.text.length==0 || passwordTextField.text.length==0 ||confirmPasswordTextField.text.length==0)
    {
        //show alert message
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Couldn't register:" message:@"Please enter valid email and password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [warningAlert show];
    }
    else
    {
        if([self validateEmail:emailTextField.text])
        {
            
            
            if([passwordTextField.text isEqualToString:confirmPasswordTextField.text])
            {
                PFUser *user = [PFUser user];
                user.username = emailTextField.text;
                user.password =passwordTextField.text;
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
                 {
                     if (error) // Something went wrong
                     {
                         // Display an alert view to show the error message
                         UIAlertView *alertView =
                         [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"]
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Ok", nil];
                         [alertView show];
                         
                         // Bring the keyboard back up, user will probably need to change something
                         [emailTextField becomeFirstResponder];
                         return;
                     }
                     
                     // Success!
                      [self performSegueWithIdentifier:@"HomeSegue"sender:self];
   
                 }];
                
                
               
                
            }
            else
            {
                UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Couldn't register:" message:@"Looks like the passwords didn't match." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [warningAlert show];

                
                
            }
            
            

            
            
        }
        else
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Couldn't register:" message:@"Please enter valid email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [warningAlert show];
            
        }
    }

    
   
}

- (IBAction)pressFacebook:(id)sender {
    
}

- (IBAction)pressBack:(id)sender {
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
    
}

#pragma mark- Helper function
-(BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; //  return 0;
    return [emailTest evaluateWithObject:candidate];
}

@end
