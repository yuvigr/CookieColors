//
//  User+signIn.m
//  CookieColors
//
//  Created by Yoav Gross on 9/24/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import"User+SignIn.h"
#import "Album+Create.h"
#import "LoginCenterViewController.h"

@implementation User (SignIn)
//a method to insert a new user to the database
+(User *)signinWithUserData:(NSDictionary *)userData inManagedObjectContext:(NSManagedObjectContext *)context
{
    User *user = nil;
    user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    user.name = [userData objectForKey:USER_NAME];
    user.child = [userData objectForKey:USER_CHILD];
    user.password = [userData objectForKey:USER_PASSWORD];
    user.wantMovie = [userData objectForKey:DO_YOU_WANT_MOVIE];
    user.icon = [userData objectForKey:USER_ICON];
    user.signInDate = [userData objectForKey:SIGN_IN_DATE];
    user.idNumber = [userData objectForKey:USER_ID];
    user.albums = [[NSSet alloc]init];
    NSMutableSet *ms = [user.albums mutableCopy];
    [ms addObject:[Album createAlbumWithName:@"My Albums" inManagedObjectContext:context]];
    user.albums = ms;
    return user;
}
//a method to delete a user from the database
+(void)deleteUserFromDatabase:(NSString *)idNumber fromManagedObjectContext:(NSManagedObjectContext *)context
{
    User *user = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"idNumber == %@",idNumber];
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"idNumber" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sd];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || matches.count > 1) {
        NSLog(@"user fetch has had an error");
    }else if (matches.count == 0){
        NSLog(@"User does not exist in database");
    }else{
        user = [matches lastObject];
        [context deleteObject:user];
        NSLog(@"user has been deleted");
    }
    
}

@end
