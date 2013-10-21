//
//  ChildSignInTableViewController.h
//  CookieColors
//
//  Created by Yoav Gross on 9/23/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChildSignInViewController;

@protocol popoverDissmisel <NSObject>

-(void)dismissPopover:(ChildSignInViewController *)sender;
-(void)getImage:(UIImage *)image andName:(NSString *)name fromSender:(ChildSignInViewController *)sender;

@end

@interface ChildSignInViewController : UIViewController

@property (nonatomic, weak) id <popoverDissmisel> delegate;
@property (nonatomic, strong) NSString *userName; //holds the user name that was given
@property (nonatomic, strong) UIImage *userImage; //holds the user image that was taken
@property (nonatomic, strong) NSMutableArray *namesInDatabase;

@end
