//
//  Discover_RootViewController.m
//  Step-it-up
//
//  Created by syfll on 15/7/30.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Discover_RootViewController.h"


@interface Discover_RootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) ODRefreshControl *refreshControl;
@property (nonatomic, strong) RKSwipeBetweenViewControllers *nav_tweet;

@end

@implementation Discover_RootViewController

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

        [tableView registerClass:[DiscoverCell class] forCellReuseIdentifier:kCellIdentifier_Discover];
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

    _nav_tweet = [RKSwipeBetweenViewControllers newSwipeBetweenViewControllers];
    [_nav_tweet.viewControllerArray addObjectsFromArray:@[[[Tweet_RootViewController alloc]init],
                                                         [[DynamicTodo_RootViewController alloc]init]]];
    _nav_tweet.buttonText = @[@"好友动态", @"日程动态"];
    
    

}



#pragma mark - ODRefreshControl
-(void)refresh{
    NSLog(@"\nRefresh :%@",NSStringFromClass([self class]));
    [self.myTableView reloadData];
    [self.refreshControl endRefreshing];
    
    
}
#pragma mark  refresh
- (void)refreshMore{

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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Discover forIndexPath:indexPath];
    if (indexPath.section == 0 ) {
        [cell setImageAndTitle:@"found_dynamic" title:@"关注动态"];
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                [cell setImageAndTitle:@"found_plan" title:@"热门计划"];
                break;
            case 1:
                [cell setImageAndTitle:@"found_local" title:@"同城用户"];
                break;
            case 2:
                [cell setImageAndTitle:@"found_localplan" title:@"同城计划"];
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 2){
        [cell setImageAndTitle:@"found_people" title:@"红人榜"];
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DiscoverCell cellHeight];
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
    if (indexPath.section == 0 ) {
        
//        [_nav_tweet setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//        [self.navigationController presentModalViewController:_nav_tweet animated:YES];

        //[self.navigationController presentViewController:_nav_tweet animated:NO completion:nil ];
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:{
                Tweet_RootViewController * tweetVC = [[Tweet_RootViewController alloc]init];
                [self.navigationController pushViewController:tweetVC animated:YES];
            }
                break;
            case 1:{
                Tweet_RootViewController * tweetVC = [[Tweet_RootViewController alloc]init];
                [self.navigationController pushViewController:tweetVC animated:YES];
            }
                break;
            case 2:{
                Tweet_RootViewController * tweetVC = [[Tweet_RootViewController alloc]init];
                [self.navigationController pushViewController:tweetVC animated:YES];
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 2){
        Tweet_RootViewController * tweetVC = [[Tweet_RootViewController alloc]init];
        [self.navigationController pushViewController:tweetVC animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
