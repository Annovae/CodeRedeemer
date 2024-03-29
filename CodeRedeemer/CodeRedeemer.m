//
//  CodeRedeemer.m
//  CodeRedeemer
//
//  Created by Michael Rebello on 4/27/13.
//  Copyright (c) 2013 Michael Rebello. All rights reserved.
//

#import "CodeRedeemer.h"

@interface CodeRedeemer ()

@end

@implementation CodeRedeemer
@synthesize webData;

//Called from other classes to check a promo code
-(void)submitCode:(NSString *)enteredCode atURL:(NSString *)url sender:(UIViewController *)sender whenComplete:(SEL)success ifFails:(SEL)failure {
    
    //Allocate NSUserDefaults
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    //Set values for later
    URL = [NSURL URLWithString:url]; 
    code = [NSMutableString stringWithString:enteredCode]; 
    requestSender = sender;
    successCall = success;
    failureCall = failure;
    
    //Start request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection) {
        webData = [NSMutableData data];
    }
}

//Connection received a response
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	
    [webData setLength:0];
}

//Connection received data
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	
    [webData appendData:data];
}

//Connection failed
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Validation failed. Please check your internet connection." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alert show];
    
    NSLog(@"Validation failed with error: %@", error);
    
    //Send a failure callback to the main view controller and suppress the Xcode warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([requestSender respondsToSelector:failureCall]) {
        [requestSender performSelector:failureCall];
    }
#pragma clang diagnostic pop
}

//Connection completed
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *text = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    
    //See if code is valid
    if ([text isEqualToString:code]) {
        
        //Save the code so it can't be used again
        [userDefaults setObject:code forKey:@"CR_LastCode"];
        
        //Send a success callback to the main view controller and suppress the Xcode warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([requestSender respondsToSelector:successCall]) {
            [requestSender performSelector:successCall];
        }
#pragma clang diagnostic pop
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The code you entered is invalid. Please check to make sure this is the correct code and try again." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        
        //Send a failure callback to the main view controller and suppress the Xcode warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([requestSender respondsToSelector:failureCall]) {
            [requestSender performSelector:failureCall];
        }
#pragma clang diagnostic pop
    }
}

@end