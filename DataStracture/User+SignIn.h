//
//  User+signIn.h
//  CookieColors
//
//  Created by Yoav Gross on 9/24/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "User.h"

@interface User (SignIn)

+(User *)signinWithUserData:(NSDictionary *)userData inManagedObjectContext:(NSManagedObjectContext *)context;
+(void)deleteUserFromDatabase:(NSString *)idNumber fromManagedObjectContext:(NSManagedObjectContext *)context;

@end
