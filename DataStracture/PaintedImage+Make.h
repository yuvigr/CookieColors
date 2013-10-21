//
//  PaintedImage+Make.h
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "PaintedImage.h"

@interface PaintedImage (Make)

+(PaintedImage *)saveAPaintedImageFromDictionary:(NSDictionary *)imageDictionary toManagedObjectContext:(NSManagedObjectContext * )context;
+(void)deletePaintedImage:(NSString *)imageName fromManagedObjectContext:(NSManagedObjectContext *)context;

@end
