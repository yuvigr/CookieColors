//
//  ProcessedImage+Create.h
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "ProcessedImage.h"

@interface ProcessedImage (Create)

+(ProcessedImage *)addAProcessedImage:(NSString *)processedImageName toManagedObjectContext:(NSManagedObjectContext *)context;
+(void)deleteProcessedImage:(NSString *)processedImageName fromManagedObjectContext:(NSManagedObjectContext *)context;

@end
