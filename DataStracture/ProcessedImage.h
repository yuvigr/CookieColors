//
//  ProcessedImage.h
//  CookieColors
//
//  Created by Yoav Gross on 9/24/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface ProcessedImage : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Image *processedFrom;

@end
