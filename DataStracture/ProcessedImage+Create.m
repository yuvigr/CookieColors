//
//  ProcessedImage+Create.m
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "ProcessedImage+Create.h"

@implementation ProcessedImage (Create)

+(ProcessedImage *)addAProcessedImage:(NSString *)processedImageName toManagedObjectContext:(NSManagedObjectContext *)context
{
    ProcessedImage *pi = nil;
    pi = [NSEntityDescription insertNewObjectForEntityForName:@"ProcessedImage" inManagedObjectContext:context];
    pi.name = processedImageName;
    return pi;
}
+(void)deleteProcessedImage:(NSString *)processedImageName fromManagedObjectContext:(NSManagedObjectContext *)context
{
    ProcessedImage *pi = nil;
    NSFetchRequest *requset = [NSFetchRequest fetchRequestWithEntityName:@"ProcessedImage"];
    requset.predicate = [NSPredicate predicateWithFormat:@"name == %@", processedImageName];
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    requset.sortDescriptors = [NSArray arrayWithObject:sd];
    
    NSError *err;
    NSArray *matches = [context executeFetchRequest:requset error:&err];
    
    if(err || !matches || matches.count > 1){
        NSLog(@"processedImage fetch has had an error");
    }else if (matches.count == 0){
        NSLog(@"processedImage does not exist");
    }else{
        pi = [matches lastObject];
        [context deleteObject:pi];
        NSLog(@"processedImage has been deleted");
    }
}


@end
