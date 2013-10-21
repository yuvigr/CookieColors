//
//  ChildLoginCenterViewController.m
//  CookieColors
//
//  Created by Yoav Gross on 9/23/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "ChildLoginCenterViewController.h"
#import "LoginCenterViewController.h"
#import "PhotoPickerViewController.h"
#import "User+SignIn.h"



@interface ChildLoginCenterViewController ()

@property (strong, nonatomic) IBOutlet UIButton *imageButton1;
@property (strong, nonatomic) IBOutlet UIButton *imageButton2;
@property (strong, nonatomic) IBOutlet UIButton *imageButton3;
@property (strong, nonatomic) IBOutlet UIButton *imageButton4;
@property (strong, nonatomic) IBOutlet UILabel *nameLable1;
@property (strong, nonatomic) IBOutlet UILabel *nameLable2;
@property (strong, nonatomic) IBOutlet UILabel *nameLable3;
@property (strong, nonatomic) IBOutlet UILabel *nameLable4;
@property (strong, nonatomic) UIPopoverController *pop;
@property (strong, nonatomic) UIButton *pressedButton;
@property (strong, nonatomic) UILabel *pressedLable;
@property (strong, nonatomic) NSMutableArray *allNamesInDatabase;

@end

@implementation ChildLoginCenterViewController

-(void)setUserData:(UIManagedDocument *)userData
{
    if(_userData != userData){
        _userData = userData;
    }
}

/* action methods to create users (1,2,3,4) for the game */

- (IBAction)chooseUser1:(UIButton *)sender
{
    if (sender.alpha == 0.5) {//if edit mode has become available, then is this button was pessed delete this user
        
        User *user = [self.users objectAtIndex:0];
        NSLog(@"name: %@",user.name);
        [User deleteUserFromDatabase:user.idNumber fromManagedObjectContext:self.userData.managedObjectContext];
        [self saveContex];
        
        [sender setAlpha:1];
        [self updateViewData];
        [self.view setNeedsDisplay];
    }else{
        self.pressedButton = sender;
        self.pressedLable = self.nameLable1;
        if (sender.currentImage){
            
            [self performSegueWithIdentifier:@"Image Picker" sender:self];
        } else {
            
            [self performSegueWithIdentifier:@"Go to user sign In" sender:self];
        }
   
    }
}

- (IBAction)chooseUser2:(UIButton *)sender
{
    self.pressedButton = sender;
    self.pressedLable = self.nameLable2;
    if (sender.currentImage){
        
        [self performSegueWithIdentifier:@"Image Picker" sender:self];
    } else {
        
        [self performSegueWithIdentifier:@"Go to user sign In" sender:self];
    }
}

- (IBAction)chooseUser3:(UIButton *)sender
{
    self.pressedButton = sender;
    self.pressedLable = self.nameLable3;
    if (sender.currentImage){
        
        [self performSegueWithIdentifier:@"Image Picker" sender:self];
    } else {
        
        [self performSegueWithIdentifier:@"Go to user sign In" sender:self];
    }
}

- (IBAction)chooseUser4:(UIButton *)sender
{
    self.pressedButton = sender;
    self.pressedLable = self.nameLable4;
    if (sender.currentImage){
        
        [self performSegueWithIdentifier:@"Image Picker" sender:self];
    } else {
        
        [self performSegueWithIdentifier:@"Go to user sign In" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Go to user sign In"]){
        self.pop = [(UIStoryboardPopoverSegue *)segue popoverController];//get the reference to the popoverViewController
        [self.pop setPopoverContentSize:CGSizeMake(330, 330)];
        ChildSignInViewController *childSign = (ChildSignInViewController *)self.pop.contentViewController;
        childSign.delegate = self;
        [segue.destinationViewController setNamesInDatabase:self.allNamesInDatabase];//send all the names of the users in the data base
    }else if ([segue.identifier isEqualToString:@"Image Picker"]){
        [segue.destinationViewController setUserDataDocument:self.userData];
        
    }else if ([segue.identifier isEqualToString:@"Go to parents login"]){
        [segue.destinationViewController setUserData:self.userData];
    }
}

    /* the popoverDismissle delegate methods */

//Dissmiss the signin popover with the ChildSignInView delegate
-(void)dismissPopover:(ChildSignInViewController *)sender
{
    [self.pop dismissPopoverAnimated:YES];
}

-(void)getImage:(UIImage *)image andName:(NSString *)name fromSender:(ChildSignInViewController *)sender
{
    [User signinWithUserData:[self createDicWithImage:image andName:name] inManagedObjectContext:self.userData.managedObjectContext];
    [self saveContex];
    [self.pop dismissPopoverAnimated:YES];
    [self updateViewData];
    [self.view setNeedsDisplay];
}
    /* end of delegate methods */

//create the dictionary for the creation of the user, using all of the defined kyes
-(NSDictionary *)createDicWithImage:(UIImage *)image andName:(NSString *)name
{
    NSDictionary *userInfo = @{USER_NAME : name, USER_CHILD : @YES, USER_PASSWORD : @"", USER_ICON : UIImageJPEGRepresentation(image, 1), DO_YOU_WANT_MOVIE : @NO, SIGN_IN_DATE : [NSDate date], USER_ID : [self getRandomID]};
    return userInfo;
}
//create a random number to be the user ID
-(NSString *)getRandomID
{
    int random = arc4random() % 100000000;
    NSString *randomID = [NSString stringWithFormat:@"%i", random];
    return randomID;
}

- (IBAction)EditDatabase:(UIButton *)sender
{
    [self.imageButton1 setAlpha:0.5];
    [self.imageButton2 setAlpha:0.5];
    [self.imageButton3 setAlpha:0.5];
    [self.imageButton4 setAlpha:0.5];
    
    [self.view setNeedsDisplay];
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
    [self updateViewData];
    [self.navigationController setNavigationBarHidden:NO];

    
	// Do any additional setup after loading the view.
}

//a method to fetch all the child users from the data base (not useing the User+signin class)
-(void)updateViewData
{
    //update the users array (users)
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"child == YES"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    //execute the fetch
    NSError *err;
    NSArray *matches = [self.userData.managedObjectContext executeFetchRequest:request error:&err];
    NSLog(@"%i", matches.count); //TODO: erase the log
    self.users =  matches;
    
    
    //Update the array names list (allNamesInDatabase)
    self.allNamesInDatabase = [[NSMutableArray alloc]init];
    NSArray *buttonArr = @[self.imageButton1, self.imageButton2, self.imageButton3, self.imageButton4];
    NSArray *lableArr = @[self.nameLable1, self.nameLable2, self.nameLable3, self.nameLable4];
    [self resetButtons:buttonArr AndLables:lableArr];
    int i = 0;
    //update the UI with all the user data and photos
    for(User *user in self.users){
        UIButton *buton = [buttonArr objectAtIndex:i];
        UILabel *lable = [lableArr objectAtIndex:i];
        [buton setImage:[UIImage imageWithData:user.icon] forState:UIControlStateNormal];
        [lable setText:user.name];
        [self.allNamesInDatabase addObject:user.name];
        i++;
    }

}
//reset the state of the buttons and lables
-(void)resetButtons:(NSArray *)buttons AndLables:(NSArray *)lables
{
    for (UIButton *but in buttons) {
        [but setImage:nil forState:UIControlStateNormal];
    }
    for (UILabel *lab in lables) {
        [lab setText:@""];
    }
}

-(void)saveContex
{
    [self.userData saveToURL:self.userData.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
        if(success){
            NSLog(@"success:save document %@", self.userData.localizedName);
        }
        if(!success){
            NSLog(@"failed to dave the document %@", self.userData.localizedName);
        }
    }];
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
