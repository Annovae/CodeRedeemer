//
//  CodeRedeemerViewController.m
//  CodeRedeemer
//
//  Created by Michael Rebello on 4/27/13.
//  Copyright (c) 2013 Michael Rebello. All rights reserved.
//

#import "CodeRedeemerViewController.h"

#import "CodeRedeemer.h"

@interface CodeRedeemerViewController ()

@end

@implementation CodeRedeemerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    indicator.hidden = loadingLabel.hidden = TRUE;
    
    //Show popup requesting promo code
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Code" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {

        NSString *code = [[alertView textFieldAtIndex:0] text];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if (![code isEqualToString:[defaults stringForKey:@"CR_LastCode"]]) {
            
            indicator.hidden = loadingLabel.hidden = FALSE;
            
            CodeRedeemer *cRedeemer = [CodeRedeemer alloc];
            [cRedeemer submitCode:code atURL:@"https://sites.google.com/site/michaelrebelloapps/access-codes/TestAccessCode.txt?attredirects=0&d=1" sender:self whenComplete:@selector(successCallback) ifFails:@selector(failureCallback)];
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The code you entered has already been redeemed." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alert show];
        }
    }
}

-(void)successCallback {
    
    indicator.hidden = loadingLabel.hidden = TRUE;

    NSLog(@"Succeeded");
}

-(void)failureCallback {
    
    indicator.hidden = loadingLabel.hidden = TRUE;

    NSLog(@"Failed");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
