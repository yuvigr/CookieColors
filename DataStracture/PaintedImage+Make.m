//
//  PaintedImage+Make.m
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "PaintedImage+Make.h"

#define IMAGE_NAME @"name"
#define IS_DONE @"done"

@implementation PaintedImage (Make)

+(PaintedImage *)saveAPaintedImageFromDictionary:(NSDictionary *)imageDictionary toManagedObjectContext:(NSManagedObjectContext *)context
{
    PaintedImage *pi = nil;
    pi = [NSEntityDescription insertNewObjectForEntityForName:@"PaintedImage" inManagedObjectContext:context];
    pi.name = [imageDictionary objectForKey:IMAGE_NAME];
    pi.done = [imageDictionary objectForKey:IS_DONE];
    return pi;
}

+(void)deletePaintedImage:(NSString *)imageName fromManagedObjectContext:(NSManagedObjectContext *)context
{
    PaintedImage *pi = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PaintedImage"];
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@", imageName];
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sd];
    
    NSError *err;
    NSArray *matches = [context executeFetchRequest:request error:&err];
    
    if(err || !matches || matches.count > 1){
        NSLog(@"paintedImage fetch has had error");
    }else if (matches.count == 0){
        NSLog(@"the paintedImage does not exist");
    }else{
        pi = [matches lastObject];
        [context deleteObject:pi];
        NSLog(@"the image has been deleted");
    }
    
}

@end
