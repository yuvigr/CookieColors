//
//  Mail.h
//  CookieColors
//
//  Created by Yoav Gross on 9/24/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Mail : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) User *belongsTo;

@end
