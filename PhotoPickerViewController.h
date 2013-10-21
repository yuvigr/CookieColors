//
//  PhotoPickerViewController.h
//  CookieColors
//
//  Created by Yoav Gross on 10/3/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoPickerViewController : UIViewController

@property (strong, nonatomic) UIImage *userImage;
@property (strong, nonatomic) UIManagedDocument *userDataDocument;

@end
