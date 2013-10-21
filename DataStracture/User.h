//
//  User.h
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album, Mail;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * child;
@property (nonatomic, retain) NSData * icon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSDate * signInDate;
@property (nonatomic, retain) NSNumber * wantMovie;
@property (nonatomic, retain) NSString * idNumber;
@property (nonatomic, retain) NSSet *albums;
@property (nonatomic, retain) NSSet *mails;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAlbumsObject:(Album *)value;
- (void)removeAlbumsObject:(Album *)value;
- (void)addAlbums:(NSSet *)values;
- (void)removeAlbums:(NSSet *)values;

- (void)addMailsObject:(Mail *)value;
- (void)removeMailsObject:(Mail *)value;
- (void)addMails:(NSSet *)values;
- (void)removeMails:(NSSet *)values;

@end
