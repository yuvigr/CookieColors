//
//  Album+Create.h
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "Album.h"

@interface Album (Create)

+(Album *)createAlbumWithName:(NSString *)albumName inManagedObjectContext:(NSManagedObjectContext *)context;
+(void)deleteAlbum:(NSString *)albumName fromManagedObjctContext:(NSManagedObjectContext *)contxt;

@end
