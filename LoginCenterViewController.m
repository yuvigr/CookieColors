//
//  LoginCenterViewController.m
//  CookieColors
//
//  Created by Yoav Gross on 9/23/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "LoginCenterViewController.h"
#import "ChildLoginCenterViewController.h"
#import "ParentsLoginCenterViewController.h"

@interface LoginCenterViewController ()

@end

@implementation LoginCenterViewController

-(void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.userDatabase.fileURL path]]) {
        [self.userDatabase saveToURL:self.userDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            
        }];
    }else if (self.userDatabase.documentState == UIDocumentStateClosed){
        [self.userDatabase openWithCompletionHandler:^(BOOL success){
            
        }];
    }else if (self.userDatabase.documentState == UIDocumentStateNormal)
    {
        
    }
}
//if the property was setted and it is not the same one we need to chage it and check to see its state
-(void)setUserDatabase:(UIManagedDocument *)userDatabase
{
    if (_userDatabase != userDatabase) {
        _userDatabase = userDatabase;
        [self useDocument];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Go to children login"]){
        [segue.destinationViewController setUserData:self.userDatabase];
    }else if ([segue.identifier isEqualToString:@"Go to parents login"]){
        [segue.destinationViewController setUserData:self.userDatabase];
    }
}

//in the viewDidLoad we will create the managedDocument to the file we want in the documents directory
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
    url = [url URLByAppendingPathComponent:@"User Database"];
    self.userDatabase = [[UIManagedDocument alloc]initWithFileURL:url];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(goSegueue) userInfo:nil repeats:NO];
    [self.navigationController setNavigationBarHidden:YES];
	// Do any additional setup after loading the view.
}

-(void)goSegueue
{
    [self performSegueWithIdentifier:@"Go to children login" sender:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
       toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        return YES;
    }
    return NO;
}

@end
