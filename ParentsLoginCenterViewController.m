//
//  ParentsLoginCenterViewController.m
//  CookieColors
//
//  Created by Yoav Gross on 9/23/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "ParentsLoginCenterViewController.h"
#import "ParentsSettingsTableViewController.h"
#import "User+SignIn.h"

@interface ParentsLoginCenterViewController ()

@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (nonatomic) BOOL userExist;
@property (strong, nonatomic) User *user;

@end

@implementation ParentsLoginCenterViewController

-(void)setUserData:(UIManagedDocument *)userData
{
    if(_userData != userData){
        _userData = userData;
    }
}
//if the user tries to log in as a parent
- (IBAction)login:(UIButton *)sender
{
    NSString *userName = self.userName.text;//get the text from the userName lable
    NSString *userPassword = self.userPassword.text;//get the text from the userPassword lable
    for(User *u in self.users){//and search it in the users array
        if([u.name isEqualToString:userName]){
            if ([u.password isEqualToString:userPassword]) {
                self.userExist = YES;
                self.user = u;
                [self performSegueWithIdentifier:@"Go to parent settings" sender:self];
            }
        }
    }
    NSLog(@"tell the user that the user entered data does not exist");
}
//is the user wants to sign in to the app as a parent
- (IBAction)signIn:(UIButton *)sender
{
    self.userExist = NO;
    [self performSegueWithIdentifier:@"Go to parent settings" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Go to parent settings"]){
        if(self.userExist){
            //set the current user to change it
            [segue.destinationViewController setCurrentUser:self.user];
        }else{
            //don't set the property cuz the user doesn't exist
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userExist = NO;//set the boolean value of user exist to NO;
    [self reloadData];
	// Do any additional setup after loading the view.
}
//relod all the non child users
-(void)reloadData
{
    //update the users array (users)
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"child == NO"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    //execute the fetch
    NSError *err;
    NSArray *matches = [self.userData.managedObjectContext executeFetchRequest:request error:&err];
    NSLog(@"%i", matches.count); //TODO: erase the log
    self.users =  matches;
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

- (void)viewDidUnload {
    [self setVideoView:nil];
    [self setUserName:nil];
    [self setUserPassword:nil];
    [super viewDidUnload];
}
@end
