//
//  RootViewController.m
//  GTTableViewController
//
//  Created by 龚涛 on 11/11/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import "RootViewController.h"
#import "NormalViewController.h"
#import "DataSourceViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    
    self.title = @"Home";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Inheritance" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 0.0, 100.0, 40.0);
    button.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-50);
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 0;
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"DataSource" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 0.0, 100.0, 40.0);
    button.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2+50);
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1;
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPressed:(id)sender
{
    switch ([sender tag]) {
        case 0:{
            [self.navigationController pushViewController:[[NormalViewController alloc] init] animated:YES];
            break;
        }
        case 1:{
            [self.navigationController pushViewController:[[DataSourceViewController alloc] init] animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
