//
//  PhotoPickerViewController.m
//  CookieColors
//
//  Created by Yoav Gross on 10/3/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "PhotoPickerViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MyAlbumsCollectionViewController.h"
#import "MyAlbumsTableViewController.h"


@interface PhotoPickerViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *pop;

@end

@implementation PhotoPickerViewController

- (IBAction)takePhotoFromCamera:(UIButton *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//check if u can take a photo
        NSArray *mediaType = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if ([mediaType containsObject:(NSString *)kUTTypeImage]) {//check if the media type is compatible
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            //resent the picker from a popover
            self.pop = [[UIPopoverController alloc] initWithContentViewController:picker];
            self.pop.delegate = self;
        }
    }
}

- (IBAction)takePhotoFromGallery:(UIButton *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {//check if u can take a photo
        NSArray *mediaType = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        if ([mediaType containsObject:(NSString *)kUTTypeImage]) {//check if the media type is compatible
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            //resent the picker from a popover
            self.pop = [[UIPopoverController alloc]initWithContentViewController:picker];
            self.pop.delegate = self;
            //create the pop over and present it
            
            [self.pop presentPopoverFromRect:CGRectMake(699, 352, 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        }
    }
}

-(IBAction)showMyAlbums:(UIButton *)sender
{//if the system device is supported by ios6 and above
    if([[[UIDevice currentDevice]systemVersion] intValue] >= 6){
        [self performSegueWithIdentifier:@"albums ios6" sender:self];
    }else{
        [self performSegueWithIdentifier:@"albums ios5" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"albums ios6"]) {
        [segue.destinationViewController setUserData:self.userDataDocument];
    }else if ([segue.identifier isEqualToString:@"albums ios5"]){
        [segue.destinationViewController setUserData:self.userDataDocument];
    }
}

//private method to dismiss the popover
-(void)dismissImagePicker
{
    [self.pop dismissPopoverAnimated:YES];
}

#pragma mark UIImagePicker delegate mathods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.userImage = [info objectForKey:UIImagePickerControllerEditedImage];//because the user can edit get the edited image
    if (!self.userImage) {
        self.userImage = [info objectForKey:UIImagePickerControllerOriginalImage];//if the user didnt edited get the original image
    }
    [self dismissImagePicker];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.pop dismissPopoverAnimated:YES];//just dismiss the popover
}

#pragma mark UIimagePicker end delegate methods



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
	// Do any additional setup after loading the view.
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
