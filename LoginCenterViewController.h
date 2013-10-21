//
//  LoginCenterViewController.h
//  CookieColors
//
//  Created by Yoav Gross on 9/23/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import <UIKit/UIKit.h>

#define USER_NAME @"name"
#define USER_CHILD @"child"
#define USER_PASSWORD @"password"
#define DO_YOU_WANT_MOVIE @"wantMovie"
#define USER_ICON @"icon"
#define SIGN_IN_DATE @"signInDate"
#define USER_ID @"id"

@interface LoginCenterViewController : UIViewController

@property (strong, nonatomic) UIManagedDocument *userDatabase;//managed document for the user data

@end
