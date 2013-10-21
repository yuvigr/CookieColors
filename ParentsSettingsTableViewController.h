//
//  ParentsSettingsTableViewController.h
//  CookieColors
//
//  Created by Yoav Gross on 10/12/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User+SignIn.h"

@interface ParentsSettingsTableViewController : UITableViewController

@property (strong, nonatomic) User *currentUser;//the user we want to save or change the data in it

@end
