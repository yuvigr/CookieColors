//
//  Image+Take.h
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "Image.h"

@interface Image (Take)

+(Image *)addImage:(NSString *)imageName inManagedObjectContext:(NSManagedObjectContext *)context;
+(void)deleteImage:(NSString *)imageName fromManagedObjectContext:(NSManagedObjectContext *)context;

@end
