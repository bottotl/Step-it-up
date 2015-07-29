//
//  RegisterViewController.m
//  Step-it-up
//
//  Created by syfll on 15/7/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "RegisterViewController.h"
#import "TTTAttributedLabel.h"
@interface RegisterViewController ()<UITableViewDataSource, UITableViewDelegate, TTTAttributedLabelDelegate>


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController.childViewControllers.count <= 1) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithBtnTitle:@"取消" target:self action:@selector(dismissSelf)];
    }
    
}
- (void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
