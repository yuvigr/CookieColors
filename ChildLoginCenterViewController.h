//
//  ChildLoginCenterViewController.h
//  CookieColors
//
//  Created by Yoav Gross on 9/23/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildSignInViewController.h"

@interface ChildLoginCenterViewController : UIViewController <popoverDissmisel>

@property (strong, nonatomic) UIManagedDocument *userData;//the managed document for the user data
@property (strong, nonatomic) NSArray *users;//all the users that are in the data base

@end
