//
//  UserInfoViewController.m
//  Step-it-up
//
//  Created by syfll on 15/7/30.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "UserInfoViewController.h"
#import "EaseUserHeaderView.h"
#import "ODRefreshControl.h"
#import "UserInfoIconCell.h"
#import "MJPhotoBrowser.h"
#import "RDVTabBarController.h"

@interface UserInfoViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) EaseUserHeaderView *headerView;
@property (strong, nonatomic) ODRefreshControl *refreshControl;

@end

@implementation UserInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //    添加myTableView
    self.curUser = [self fakeCreateUser];
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = kColorTableSectionBg;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[UserInfoIconCell class] forCellReuseIdentifier:kCellIdentifier_UserInfoIconCell];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.rdv_tabBarController.tabBar.frame), 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;

        tableView;
    });
    __weak typeof(self) weakSelf = self;
#warning 暂时用本地图片代替
    _headerView = [EaseUserHeaderView userHeaderViewWithUser:_curUser image:[UIImage imageNamed:@"add_user_icon"]];
    //_headerView = [EaseUserHeaderView userHeaderViewWithUser:_curUser image:[StartImagesManager shareManager].curImage.image];
    _headerView.userIconClicked = ^(){
        [weakSelf userIconClicked];
    };
    _headerView.fansCountBtnClicked = ^(){
        [weakSelf fansCountBtnClicked];
    };
    _headerView.followsCountBtnClicked = ^(){
        [weakSelf followsCountBtnClicked];
    };
//    _headerView.followBtnClicked = ^(){
//        [weakSelf followBtnClicked];
//    };
    [_myTableView addParallaxWithView:_headerView andHeight:CGRectGetHeight(_headerView.frame)];
    //_myTableView.tableFooterView = [self footerV];
    
    
    _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.myTableView];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];

}
- (void)refresh{
//    __weak typeof(self) weakSelf = self;
//    [[Coding_NetAPIManager sharedManager] request_UserInfo_WithObj:_curUser andBlock:^(id data, NSError *error) {
//        [weakSelf.refreshControl endRefreshing];
//        if (data) {
//            weakSelf.curUser = data;
//            weakSelf.headerView.curUser = data;
//            weakSelf.title = _isRoot? @"我": weakSelf.curUser.name;
//            [weakSelf.myTableView reloadData];
//        }
//    }];
    self.headerView.curUser = _curUser;
    self.title = @"我";
    
    [self.refreshControl endRefreshing];
    [self.myTableView reloadData];
}

#pragma mark footerV
- (UIView *)footerV{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 72)];
    
    UIButton *footerBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"发消息" andFrame:CGRectMake(kPaddingLeftWidth, (CGRectGetHeight(footerV.frame)-44)/2 , kScreen_Width - 2*kPaddingLeftWidth, 44) target:self action:@selector(messageBtnClicked)];
    [footerV addSubview:footerBtn];
    return footerV;
}


#pragma mark Btn Clicked
- (void)fansCountBtnClicked{
    NSLog(@"fansCountBtnClicked\n");
//    if (_curUser.id.integerValue == 93) {//Coding官方账号
//        return;
//    }
//    UsersViewController *vc = [[UsersViewController alloc] init];
//    vc.curUsers = [Users usersWithOwner:_curUser Type:UsersTypeFollowers];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)followsCountBtnClicked{
    NSLog(@"fansCountBtnClicked\n");
//    if (_curUser.id.integerValue == 93) {//Coding官方账号
//        return;
//    }
//    UsersViewController *vc = [[UsersViewController alloc] init];
//    vc.curUsers = [Users usersWithOwner:_curUser Type:UsersTypeFriends_Attentive];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)userIconClicked{
    //        显示大图
    MJPhoto *photo = [[MJPhoto alloc] init];
#warning 暂时用单一的网络图片代替
    photo.url = [NSURL URLWithString:@"https://coding.net//static/fruit_avatar/Fruit-2.png"];
    //photo.url = [_curUser.avatar urlWithCodePath];
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;
    browser.photos = [NSArray arrayWithObject:photo];
    [browser show];
}
//- (void)followBtnClicked{
//    __weak typeof(self) weakSelf = self;
//    [[Coding_NetAPIManager sharedManager] request_FollowedOrNot_WithObj:_curUser andBlock:^(id data, NSError *error) {
//        if (data) {
//            weakSelf.curUser.followed = [NSNumber numberWithBool:!_curUser.followed.boolValue];
//            weakSelf.headerView.curUser = weakSelf.curUser;
//            if (weakSelf.followChanged) {
//                weakSelf.followChanged(weakSelf.curUser);
//            }
//        }
//    }];
//}


#pragma mark Table M
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoIconCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_UserInfoIconCell forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell setTitle:@"日程收藏" icon:@"user_info_detail"];
    }else{
        if (indexPath.row == 0) {
            [cell setTitle:@"消息" icon:@"user_info_project"];
        }else{
            [cell setTitle:@"设置" icon:@"user_info_tweet"];
        }
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = [UserInfoIconCell cellHeight];
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    footerView.backgroundColor = kColorTableSectionBg;
    return footerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(User*)fakeCreateUser{
    User *user = [[User alloc]init];
    return user;
}

#pragma mark TabBar
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
