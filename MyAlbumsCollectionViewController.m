//
//  MyAlbumsCollectionViewController.m
//  CookieColors
//
//  Created by Yoav Gross on 10/3/13.
//  Copyright (c) 2013 Yoav Gross. All rights reserved.
//

#import "MyAlbumsCollectionViewController.h"

@interface MyAlbumsCollectionViewController ()

@end

@implementation MyAlbumsCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

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


@end
