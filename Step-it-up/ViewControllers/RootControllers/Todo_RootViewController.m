//
//  Todo_RootViewController.m
//  Step-it-up
//
//  Created by syfll on 15/7/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Todo_RootViewController.h"
#import "CalenderStyleViewController.h"
#import "BaseNavigationController.h"

@interface Todo_RootViewController ()


@end

@implementation Todo_RootViewController

-(instancetype)init{
    if ((self = [super init])) {
        self = [[UIStoryboard storyboardWithName:@"SIUToDoSB" bundle:nil]instantiateInitialViewController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
