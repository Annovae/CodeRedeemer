//
//  CodeRedeemer.h
//  CodeRedeemer
//
//  Created by Michael Rebello on 4/27/13.
//  Copyright (c) 2013 Michael Rebello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeRedeemer : UIViewController {
    
    NSUserDefaults *userDefaults;
    
    NSMutableString *code;
    
    NSURL *URL;
    
    UIViewController *requestSender;
    
    SEL successCall, failureCall;
}

@property(nonatomic, strong) NSMutableData *webData;

-(void)submitCode:(NSString *)enteredCode atURL:(NSString *)url sender:(UIViewController *)sender whenComplete:(SEL)success ifFails:(SEL)failure;

@end