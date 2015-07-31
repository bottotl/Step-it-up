//
//  Group_RootViewController.m
//  Step-it-up
//
//  Created by syfll on 15/7/30.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Group_RootViewController.h"
#import "ODRefreshControl.h"
#import "MeGroupCell.h"
#import "RDVTabBarController.h"
#import "SVPullToRefresh.h"


@interface Group_RootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) ODRefreshControl *refreshControl;
@end

@implementation Group_RootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //    添加myTableView
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundColor = kColorTableSectionBg;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [tableView registerClass:[MeGroupCell class] forCellReuseIdentifier:kCellIdentifier_Me_Group];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        {
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.rdv_tabBarController.tabBar.frame), 0);
            tableView.contentInset = insets;
            tableView.scrollIndicatorInsets = insets;
        }
        tableView;
    });
    _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.myTableView];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - refresh
-(void)refresh{
    [_myTableView reloadData];
    [self.refreshControl endRefreshing];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Me_Group forIndexPath:indexPath];
    if (indexPath.section == 0 ) {
        
        [cell setImageAndTitle:@"found_localplan" title:@"群组动态"];
    }else{
        [cell setImageAndTitle:@"found_localplan" title:@"群组名称"];
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MeGroupCell cellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 2)
        return 0;
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    headerView.backgroundColor = kColorTableSectionBg;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    footerView.backgroundColor = kColorTableSectionBg;
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - TabBar
- (void)tabBarItemClicked{
    [super tabBarItemClicked];
    if (_myTableView.contentOffset.y > 0) {
        [_myTableView setContentOffset:CGPointZero animated:YES];
    }else if (!self.refreshControl.refreshing){
        [self.refreshControl beginRefreshing];
        [self.myTableView setContentOffset:CGPointMake(0, -44)];
        [self refresh];
    }
}

@end
