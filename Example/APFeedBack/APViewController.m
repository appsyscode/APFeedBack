//
//  APViewController.m
//  APFeedBack
//
//  Created by devalios on 04/08/2016.
//  Copyright (c) 2016 devalios. All rights reserved.
//

#import "APViewController.h"
#import <APFeedBack/APFeedTableViewController.h>
#import <APFeedBack/APFeedBackConfig.h>

@interface APViewController ()

@end

@implementation APViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)feedback_Push:(id)sender;

{
    
    APFeedTableViewController *fd = [[APFeedTableViewController alloc]init];
    fd.developer_LogFile=YES;
    fd.mailHTML=YES;
    [self.navigationController pushViewController:fd animated:YES];
    
    
}

- (IBAction)feedback_modal:(id)sender

{
    
    
    
    APFeedTableViewController *fd = [[APFeedTableViewController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:fd];
    navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
