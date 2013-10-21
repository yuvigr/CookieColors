//
//  Album+Create.m
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "Album+Create.h"

@implementation Album (Create)

+(Album *)createAlbumWithName:(NSString *)albumName inManagedObjectContext:(NSManagedObjectContext *)context
{
    Album *album = nil;
    album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = albumName;
    return album;
}

+(void)deleteAlbum:(NSString *)albumName fromManagedObjctContext:(NSManagedObjectContext *)contxt
{
    Album *album = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@", albumName];
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sd];
    
    NSError *err;
    NSArray *matches = [contxt executeFetchRequest:request error:&err];
    
    if(err || !matches || matches.count > 1){
        NSLog(@"album fetch has had an error");
    }else if (matches.count == 0){
        NSLog(@"album does not exist");
    }else{
        album = [matches lastObject];
        [contxt deleteObject:album];
        NSLog(@"album has been deleted");
    }
}

@end
