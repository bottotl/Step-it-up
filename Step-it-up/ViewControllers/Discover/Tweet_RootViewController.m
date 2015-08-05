//
//  TweetViewController.m
//  Step-it-up
//
//  Created by syfll on 15/8/2.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Tweet_RootViewController.h"


@interface Tweet_RootViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@end

@implementation Tweet_RootViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _myTweets = [[Tweets alloc]init];
        _myTweets.tweets = [self fakeTweets];
    }
    return self;
}


#pragma mark lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     _myTweets.tweets = [self fakeTweets];
    
    //    添加myTableView
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        Class tweetCellClass = [TweetCell class];
        [tableView registerClass:tweetCellClass forCellReuseIdentifier:kCellIdentifier_Tweet];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        {
            __weak typeof(self) weakSelf = self;
            [tableView addInfiniteScrollingWithActionHandler:^{
                [weakSelf refreshMore];
            }];
        }
        {
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.rdv_tabBarController.tabBar.frame), 0);
            tableView.contentInset = insets;
        }
        tableView;
    });
    _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.myTableView];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    [self createDWBubbleMenuButton];

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
#pragma mark - refresh
- (void)refresh{
    [_myTweets updateTweets];
    [_myTableView reloadData];
    [self.refreshControl endRefreshing];
}
- (void)refreshMore{
    [_myTweets updateMoreTweets];
    [_myTableView reloadData];
    [self.myTableView.infiniteScrollingView stopAnimating];
    self.myTableView.showsInfiniteScrolling = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark TableM
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_myTweets.tweets) {
        return _myTweets.tweets.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Tweet forIndexPath:indexPath];

    cell.tweet = [_myTweets.tweets objectAtIndex:indexPath.row];
    
    __weak typeof(self) weakSelf = self;
        cell.likeBtnClickedBlock = ^(Tweet *tweet){
        [weakSelf.myTableView reloadData];
    };
    cell.userBtnClickedBlock = ^(User *curUser){
        UserInfoViewController *vc = [[UserInfoViewController alloc] init];
        vc.curUser = curUser;
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.moreLikersBtnClickedBlock = ^(Tweet *curTweet){
        LikersViewController *vc = [[LikersViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
//    cell.goToDetailTweetBlock = ^(Tweet *curTweet){
//        [self goToDetailWithTweet:curTweet];
//    };
//    cell.refreshSingleCCellBlock = ^(){
//        [weakSelf.myTableView reloadData];
//    };
//    cell.mediaItemClickedBlock = ^(HtmlMediaItem *curItem){
//        [weakSelf analyseLinkStr:curItem.href];
//    };
//    cell.locationClickedBlock = ^(Tweet *curTweet){
//        TweetSendLocationDetailViewController *vc = [[TweetSendLocationDetailViewController alloc]init];
//        vc.tweet = curTweet;
//        
//        if (vc.tweet.coord.length > 0) {
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        }
//    };
    
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Tweet *tweet = [_myTweets.tweets objectAtIndex:indexPath.row];
    //CGFloat height = tweet ;
    
    return [TweetCell cellHeightWithObj:tweet];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Tweets *curTweets = [self getCurTweets];
    Tweet *toTweet = [_myTweets.tweets objectAtIndex:indexPath.row];
    [self goToDetailWithTweet:toTweet];
}
- (void)goToDetailWithTweet:(Tweet *)tweet{
    TweetDetailViewController *vc = [[TweetDetailViewController alloc] init];
    vc.tweet = tweet;
//    __weak typeof(self) weakSelf = self;
//    vc.deleteTweetBlock = ^(Tweet *toDeleteTweet){
//        Tweets *curTweets = [weakSelf.myTweets objectForKey:[NSNumber numberWithInteger:weakSelf.curIndex]];
//        [curTweets.list removeObject:toDeleteTweet];
//        [weakSelf.myTableView reloadData];
//        [weakSelf.view configBlankPage:EaseBlankPageTypeTweet hasData:(curTweets.list.count > 0) hasError:NO reloadButtonBlock:^(id sender) {
//            [weakSelf sendRequest];
//        }];
//    };
    [self.navigationController pushViewController:vc animated:YES];
}



#warning fake initTweet

-(NSMutableArray *)fakeTweets{
    
    Tweet * tweet = [Tweet fakeInit];
    NSMutableArray * tweets = [[NSMutableArray alloc]initWithArray:@[tweet]];
    return tweets;
}

#pragma mark 分类弹出按钮
-(void)createDWBubbleMenuButton{
    // Create up menu button
    UIImageView *homeLabel = [self createHomeButtonView];
    
    _upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - homeLabel.frame.size.width - 20.f,
                                                                                          self.view.frame.size.height - homeLabel.frame.size.height - 60.f,
                                                                                          homeLabel.frame.size.width,
                                                                                          homeLabel.frame.size.height)
                                                            expansionDirection:DirectionUp];
    _upMenuView.homeButtonView = homeLabel;
    
    [_upMenuView addButtons:[self createDemoButtonArray]];
    
    [self.navigationController.view addSubview:_upMenuView];
   // NSLog(@"%@",);
//    [upMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view);
//        make.center.equalTo(self.view);
//    }];
    
}

- (UIButton *)createButtonWithName:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button sizeToFit];
    
    [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}



- (UIImageView *)createHomeButtonView {
    UIImageView *homeView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    [homeView setImage:[UIImage imageNamed:@"multiply_float__touch"]];
    return homeView;
}
- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *imageName in @[@"multipy_float__all", @"multipy_float__calendar", @"multipy_float__sort"]) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        button.tag = i++;
        
        [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}

- (void)test:(UIButton *)sender {
    NSLog(@"Button tapped, tag: %ld", (long)sender.tag);
    switch (sender.tag) {
        case 0:
            NSLog(@"0\n");
            break;
        case 1:
            NSLog(@"1\n");
            break;
        case 2:
            NSLog(@"2\n");
            break;
        default:
            break;
    }
}


@end
