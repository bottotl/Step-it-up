//
//  UserInfoViewController.h
//  Step-it-up
//
//  Created by syfll on 15/7/30.
//  Copyright © 2015年 JFT0M. All rights reserved.
//
//  这个页面将重复使用

#import "BaseViewController.h"
#import "User.h"
@interface UserInfoViewController : BaseViewController
@property (assign, nonatomic) BOOL isRoot;
@property (strong, nonatomic) User *curUser;
@end
