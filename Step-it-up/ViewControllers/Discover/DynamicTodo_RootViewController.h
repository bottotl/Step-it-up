//
//  DynamicTodo_RootViewController.h
//  Step-it-up
//
//  Created by syfll on 15/8/7.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "BaseViewController.h"
#import "TweetTodoCell.h"
#import "ODRefreshControl.h"

@interface DynamicTodo_RootViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
/// 展示TweetTodo(日程动态)用的
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ODRefreshControl *refreshControl;

@end
