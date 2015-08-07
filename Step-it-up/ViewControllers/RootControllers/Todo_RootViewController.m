//
//  Todo_RootViewController.m
//  Step-it-up
//
//  Created by syfll on 15/7/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Todo_RootViewController.h"
#import "BaseNavigationController.h"
#import "Todo_CalenderViewController.h"
#import "Todo_AllViewController.h"
#import "Todo_TypeViewController.h"

#import "DWBubbleMenuButton.h"
#import "XHPopMenu.h"
#import "LKAlarmEvent.h"

@interface Todo_RootViewController ()

@property (nonatomic, strong) XHPopMenu *popMenu;

@property (nonatomic, strong) Todo_CalenderViewController* calenderVC;
@property (nonatomic, strong) Todo_AllViewController* allVC;
@property (nonatomic, strong) Todo_TypeViewController* typeVC;

@end

@implementation Todo_RootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //Todo_CalenderViewController * calender = [[Todo_CalenderViewController alloc]init];
    _calenderVC =[[Todo_CalenderViewController alloc]init];
    BaseNavigationController *navi_calender = [[BaseNavigationController alloc]initWithRootViewController:_calenderVC];
    _allVC = [[Todo_AllViewController alloc]init];
    BaseNavigationController *navi_all = [[BaseNavigationController alloc]initWithRootViewController:_allVC];
    _typeVC = [[Todo_TypeViewController alloc]init];
    BaseNavigationController *navi_type = [[BaseNavigationController alloc]initWithRootViewController:_typeVC];
   self.viewControllers = @[navi_calender,navi_all,navi_type];


    _calenderVC.title = @"按日历查看";
    _allVC.title = @"按列表查看";
    _typeVC.title = @"按类型查看";
    self.selectedIndex = 0;
    [self steupButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - Set up button
-(void)steupButtons{
    //添加分类按钮
    [self createDWBubbleMenuButton];
    //为每个分页面添加“添加按钮”
    [self createAddButton:_calenderVC];
    [self createAddButton:_allVC];
    [self createAddButton:_typeVC];
}
#pragma mark 添加按钮
-(void)createAddButton:(BaseViewController *)vc{
    [vc.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showMenuOnView:)]];
    [vc.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}
- (void)showMenuOnView:(UIBarButtonItem *)buttonItem {
    [self.popMenu showMenuOnView:self.view atPoint:CGPointZero];
}
#pragma mark config popMenu
- (XHPopMenu *)popMenu {
    if (!_popMenu) {
        NSMutableArray *popMenuItems = [[NSMutableArray alloc] initWithCapacity:3];
        for (int i = 0; i < 2; i ++) {
            NSString *imageName;
            NSString *title;
            switch (i) {
                case 0: {
                    imageName = @"contacts_add_newmessage";
                    title = @"添加日程";
                    break;
                }
                case 1: {
                    imageName = @"contacts_add_friend";
                    title = @"发表状态";
                    break;
                }
                default:
                    break;
            }
            XHPopMenuItem *popMenuItem = [[XHPopMenuItem alloc] initWithImage:[UIImage imageNamed:imageName] title:title];
            [popMenuItems addObject:popMenuItem];
        }
        
        WEAKSELF
        _popMenu = [[XHPopMenu alloc] initWithMenus:popMenuItems];
        _popMenu.popMenuDidSlectedCompled = ^(NSInteger index, XHPopMenuItem *popMenuItems) {
            if (index == 1) {
                printf("发表状态 index 1\n");
                //[weakSelf enterQRCodeController];
            }else if (index == 0 ) {
                printf("添加日程 index 0\n");
                [weakSelf enterCreateScheduleController];
            }
        };
    }
    return _popMenu;
}
- (void)enterCreateScheduleController {
    printf("我要创建日程辣 ：）\n");
    LKAlarmEvent * event = [LKAlarmEvent fakeLKAlarmEvent];
    
    
    ///增加推送声音 和 角标
    [event setOnCreatingLocalNotification:^(UILocalNotification * localNotification) {
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    }];
    
    [[LKAlarmMamager shareManager] addAlarmEvent:event];
    
    
    
    ///添加到日历
    
    ///会先尝试加入日历  如果日历没权限 会加入到本地提醒中
    [[LKAlarmMamager shareManager] addAlarmEvent:event callback:^(LKAlarmEvent *alarmEvent) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(alarmEvent.isJoinedCalendar)
            {
                NSLog(@"已加入日历");
            }
            else if(alarmEvent.isJoinedLocalNotify)
            {
                NSLog(@"已加入本地通知");
            }
            else
            {
                NSLog(@"加入通知失败");
            }
            
        });
        
    }];
    
}

#pragma mark 分类弹出按钮
-(void)createDWBubbleMenuButton{
    // Create up menu button
    UIImageView *homeLabel = [self createHomeButtonView];
    
    DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - homeLabel.frame.size.width - 20.f,
                                                                                          self.view.frame.size.height - homeLabel.frame.size.height - 60.f,
                                                                                          homeLabel.frame.size.width,
                                                                                          homeLabel.frame.size.height)
                                                            expansionDirection:DirectionUp];
    upMenuView.homeButtonView = homeLabel;
    
    [upMenuView addButtons:[self createDemoButtonArray]];
    
    [self.view addSubview:upMenuView];
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
    //homeView.backgroundColor = [UIColor blackColor];
    //homeView.layer.cornerRadius = homeView.frame.size.height / 2.f;
    //homeView.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    //homeView.clipsToBounds = YES;
    
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
            //显示所有
            self.selectedIndex = 0;
            break;
        case 1:
            //显示日历模式
            self.selectedIndex = 1;
            break;
        case 2:
            //显示分类
            self.selectedIndex = 2;
            break;
        default:
            break;
    }
}

@end
