//
//  MainViewController.m
//  SmartOfficeDesktopTouch
//
//  Created by Robbie Plankenhorn on 11/6/13.
//  Copyright (c) 2013 Solstice Mobile. All rights reserved.
//

#import "MainViewController.h"
#import "HeaderViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    HeaderViewController *headerViewController = [[HeaderViewController alloc] initWithNibName:@"HeaderView" bundle:nil];
    [self.view addSubview:headerViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end