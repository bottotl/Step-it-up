//
//  Dynamic_RootViewController.m
//  Step-it-up
//
//  Created by syfll on 15/8/4.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Dynamic_RootViewController.h"
#import "Tweet_RootViewController.h"
#import "DynamicTodo_RootViewController.h"
@interface Dynamic_RootViewController ()

@end

@implementation Dynamic_RootViewController

-(instancetype)init{
    RKSwipeBetweenViewControllers *nav_tweet = [RKSwipeBetweenViewControllers newSwipeBetweenViewControllers];
    [nav_tweet.viewControllerArray addObjectsFromArray:@[[[Tweet_RootViewController alloc]init],
                                                         [[DynamicTodo_RootViewController alloc]init]]];
    nav_tweet.buttonText = @[@"好友动态", @"日程动态"];
    self = nav_tweet;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
