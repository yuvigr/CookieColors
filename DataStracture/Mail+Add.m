//
//  Mail+Add.m
//  CookieColors
//
//  Created by Yoav Gross on 10/11/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "Mail+Add.h"

@implementation Mail (Add)

+(Mail *)createAMailAdress:(NSString *)mailAddress inManagedObjectContext:(NSManagedObjectContext *)context
{
    Mail *mail = nil;
    mail = [NSEntityDescription insertNewObjectForEntityForName:@"Mail" inManagedObjectContext:context];
    mail.address = mailAddress;
    return mail;
}

+(void)deleteMailAdress:(NSString *)mailAddress fromManagedObjectContext:(NSManagedObjectContext *)context
{
    Mail *mail = nil;
    
    NSFetchRequest *requset = [NSFetchRequest fetchRequestWithEntityName:@"Mail"];
    requset.predicate = [NSPredicate predicateWithFormat:@"address == %@", mailAddress];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"address" ascending:YES];
    requset.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *err;
    NSArray *matches = [context executeFetchRequest:requset error:&err];
    
    if (err || !matches || matches.count > 1) {
        NSLog(@"mail fetch has had an error");
    }else if (matches.count == 0){
        NSLog(@"The mail doesn't exist in the database");
    }else{
        mail = [matches lastObject];
        [context deleteObject:mail];
        NSLog(@"mail has been deleted");
    }
    
}

@end
