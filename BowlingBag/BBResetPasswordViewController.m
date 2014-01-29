//
//  BBResetPasswordViewController.m
//  BowlingBag
//
//  Created by Won Kim on 1/29/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBResetPasswordViewController.h"
#import <Parse/Parse.h>
@interface BBResetPasswordViewController ()
{
    IBOutlet UITextField *emailTextField;
    
}

@end

@implementation BBResetPasswordViewController

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

#pragma mark-  Button Action

- (IBAction)pressSend:(id)sender {
    
    if([self validateEmail:emailTextField.text])
    {
        [PFUser requestPasswordResetForEmailInBackground:@"emailTextField.text"];
        
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Sent" message:@"Please check your email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [warningAlert show];
    }
    else
    {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Couldn't send:" message:@"Please enter valid email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [warningAlert show];

        
    }
    
    
    
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
