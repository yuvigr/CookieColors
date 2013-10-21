//
//  Album.h
//  CookieColors
//
//  Created by Yoav Gross on 9/24/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, User;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) User *belongsTo;
@property (nonatomic, retain) NSSet *images;
@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
