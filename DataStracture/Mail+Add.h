//
//  Mail+Add.h
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "Mail.h"

@interface Mail (Add)

+(Mail *)createAMailAdress:(NSString *)mailAddress inManagedObjectContext:(NSManagedObjectContext *)context;
+(void)deleteMailAdress:(NSString *)mailAddress fromManagedObjectContext:(NSManagedObjectContext *)context;

@end
