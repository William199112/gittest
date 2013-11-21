//
//  DemoViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 6/14/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DemoViewController.h"
#import "SecondViewController.h"
#import "THWAppDelegate.h"

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"R&M";
    self.view.backgroundColor = [UIColor blackColor];
    UIImage *imga = [UIImage imageNamed:@"11.jpg"];
    UIImageView * imgb = [[UIImageView alloc]initWithFrame:self.view.frame];
    [imgb setImage:imga];
    [self.view addSubview:imgb];
}

@end
