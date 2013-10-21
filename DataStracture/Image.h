//
//  Image.h
//  CookieColors
//
//  Created by Yoav Gross on 9/24/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album, PaintedImage, ProcessedImage;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Album *belongsTo;
@property (nonatomic, retain) ProcessedImage *bwImage;
@property (nonatomic, retain) NSSet *products;
@end

@interface Image (CoreDataGeneratedAccessors)

- (void)addProductsObject:(PaintedImage *)value;
- (void)removeProductsObject:(PaintedImage *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
