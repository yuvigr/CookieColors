//
//  Image+Take.m
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "Image+Take.h"

@implementation Image (Take)

+(Image *)addImage:(NSString *)imageName inManagedObjectContext:(NSManagedObjectContext *)context
{
    Image *image = nil;
    image = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:context];
    image.name = imageName;
    return image;
}

+(void)deleteImage:(NSString *)imageName fromManagedObjectContext:(NSManagedObjectContext *)context
{
    Image *image = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Image"];
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@", imageName];
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sd];
    
    NSError *err;
    NSArray *matches = [context executeFetchRequest:request error:&err];
    
    if(err || !matches || matches.count > 1){
        NSLog(@"image fetch has had an error");
    }else if (matches.count == 0){
        NSLog(@"the image does not exist");
    }else{
        image = [matches lastObject];
        [context deleteObject:image];
        NSLog(@"image has been deleted");
    }
}

@end
