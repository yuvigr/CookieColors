//
//  ChildSignInTableViewController.m
//  CookieColors
//
//  Created by Yoav Gross on 9/23/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "ChildSignInViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ChildSignInViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate> //conforming to the picker delegate you need to conform to thouse two protocols
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) UIPopoverController *pop;
@property (strong, nonatomic) IBOutlet UILabel *userLable;
@property (strong, nonatomic) IBOutlet UILabel *validName;

@end

@implementation ChildSignInViewController

-(void)setNamesInDatabase:(NSMutableArray *)namesInDatabase
{
    if(_namesInDatabase != namesInDatabase){
        _namesInDatabase = namesInDatabase;
    }
}

//take a photo from the camera
- (IBAction)takeAPhoto:(UIButton *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//check if u can take a photo
        NSArray *mediaType = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if ([mediaType containsObject:(NSString *)kUTTypeImage]) {//check if the media type is compatible
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            //resent the picker from a viewController
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
}
#pragma mark imagePicker delegat methods
//after the user had selected his image this method will fire
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.userImage = [info objectForKey:UIImagePickerControllerEditedImage];//because the user can edit get the edited image
    if (!self.userImage) {
        self.userImage = [info objectForKey:UIImagePickerControllerOriginalImage];//if the user didnt edited get the original image
    }
    [self dismissImagePicker];
}
//if the user had canceld the image picking then this method will fire
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissImagePicker];
}

#pragma mark imagePicker end of delegat methods

#pragma mark UITextFieldDelegate delegat methods
//check the entered text in the name text and gives a color if the entered name is valid
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *nameInText = textField.text;
    nameInText = [nameInText stringByReplacingCharactersInRange:range withString:string];
    if(nameInText.length > 0){
        for(NSString *name in self.namesInDatabase){
            if([name isEqualToString:nameInText]){
                [self.validName setBackgroundColor:[UIColor redColor]];
                return YES;
            }
        }
        [self.validName setBackgroundColor:[UIColor greenColor]];
    }else if(nameInText.length == 0){//if the lenght of the text field is 0
//        [self.validName setBackgroundColor:[UIColor redColor]];
    }
    return YES;
}
#pragma mark UITextFieldDelegate end of delegat methods

-(void)dismissImagePicker
{
    [self.pop dismissPopoverAnimated:YES];//and dismiss the popover
}

- (IBAction)cancel:(UIButton *)sender
{
    [self.delegate dismissPopover:self];//the delegate method of the first popover
}
//when the user press the done button
- (IBAction)done:(id)sender
{
    self.userImage = [UIImage imageNamed:@"Default.png"];
    self.userName = self.nameTextField.text;
//    if([self.userName isEqualToString:@""]){
//        self.userName = @"User";
//    }
    if(self.userImage && (self.validName.backgroundColor != [UIColor redColor])){//check if all the values are good and send them back
        //need to check if the name doesn't exist in the data base
        [self.delegate getImage:self.userImage andName:self.userName fromSender:self];
    }else{//if one of the properties is not good
        [self.userLable setText:@"Please enter a name\nand pick a photo"];
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
    self.nameTextField.delegate = self;
    [self.validName setBackgroundColor:[UIColor greenColor]];//empty text is not a valid name
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


@end
