//
//  HomeViewController.m
//  changer
//
//  Created by syfll on 14-12-2.
//  Copyright (c) 2014年 syfll. All rights reserved.
//

#import "ToDoCalenderStyleViewController.h"
#import "SIUMacros.h"
#import "XHPopMenu.h"
#import "LKAlarmMamager.h"
#import "ScheduleCell.h"

#define kDefaultAnimationDuration 0.25f
#define FontSize 23.0f

@interface ToDoCalenderStyleViewController (){
    NSMutableDictionary *eventsByDate;
    NSArray * tableViewDateSource;
}
@property (weak, nonatomic) IBOutlet UITableView *scheduleTableView;

@end

@implementation ToDoCalenderStyleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加日历阴影
    CALayer * calendarLayer = self.calendarContentView.superview.layer;
    //layer.cornerRadius=10;
    calendarLayer.shadowColor=[UIColor blackColor].CGColor;
    //偏移量
    calendarLayer.shadowOffset=CGSizeMake(0, 2);
    calendarLayer.shadowOpacity=0.5;
    calendarLayer.shadowRadius=3;
    //calendarLayer.shadowPath
    
    //添加按钮阴影效果
    CALayer *changeDateBtnLayer = self.changeDateBtn.layer;
    changeDateBtnLayer.shadowColor=[UIColor blackColor].CGColor;
    //偏移量
    changeDateBtnLayer.shadowOffset=CGSizeMake(0, 2);
    changeDateBtnLayer.shadowOpacity=0.5;
    changeDateBtnLayer.shadowRadius=3;
    

    //添加 changeDateBtn 响应事件
    [self.changeDateBtn addTarget:self action:@selector(didChangeModeTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    #pragma mark 设置标题栏(最顶上那一条有信号什么的东西)&标题为白色
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    //设置日程列表
    [self initScheduleTable];
    self.calendar = [JTCalendar new];
    //self.is_hiden = NO;
    //[self ShowView];
    
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    self.calendarMenuView.backgroundColor =[UIColor clearColor];
    self.calendarContentView.backgroundColor = [UIColor clearColor];
    
    self.backView.backgroundColor = [[UIColor alloc]initWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    //更新按钮图片
    if (self.calendar.calendarAppearance.isWeekMode == true) {
        [self.changeDateBtn setImage:[UIImage imageNamed:@"multiply_down"] forState:UIControlStateNormal];
    }else{
        [self.changeDateBtn setImage:[UIImage imageNamed:@"multiply_up"] forState:UIControlStateNormal];
    }
    
    tableViewDateSource = [self getEventsOneDay:self.calendar.currentDate];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}
//初始化tableView
-(void)initScheduleTable{
    
    _scheduleTableView.backgroundColor = [UIColor clearColor];
    [_scheduleTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _scheduleTableView.backgroundView = [[UIView alloc]init];
    [_scheduleTableView registerClass:[ScheduleCell class] forCellReuseIdentifier:JFScheduleCell];

}
#pragma mark - Action

#pragma mark enterQRCodeController要修改
- (void)enterQRCodeController {

    printf("。。。。");
}

- (void)enterCreateScheduleController {
    [self performSegueWithIdentifier:@"createSchedule" sender:self];
    printf("我要创建日程辣 ：）\n");
}


#pragma mark - Buttons callback
//今天按钮响应
- (void)didGoTodayTouch:(id)sender
{
    [self.calendar setCurrentDate:[NSDate date]];
}

//改变模式按钮响应
- (void)didChangeModeTouch:(id)sender
{
    //更换按钮图片
    if (self.calendar.calendarAppearance.isWeekMode == false) {
        [self.changeDateBtn setImage:[UIImage imageNamed:@"multiply_down"] forState:UIControlStateNormal];
    }else{
        [self.changeDateBtn setImage:[UIImage imageNamed:@"multiply_up"] forState:UIControlStateNormal];
    }
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    [self transitionExample];
}



#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
}
#pragma mark 日期点击回调
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    
    NSLog(@"Date: %@ - %ld events", date, [events count]);
    
    [self getLKAlarmEvents];
    tableViewDateSource = [self getEventsOneDay:date];
    [self.tableView reloadData];
    //点击日期后改变显示模式
    [self.calendar setCurrentDate: date];
    
    if (!self.calendar.calendarAppearance.isWeekMode) {
        self.calendar.calendarAppearance.isWeekMode = true;
        [self transitionExample];
    }
    
}
#pragma mark 获取提醒events
- (void)getLKAlarmEvents{
    if (!eventsByDate) {
        eventsByDate = [NSMutableDictionary new];
    }
    NSArray * events = [[LKAlarmMamager shareManager]allEvents];
    for (int i = 0; i< events.count; i++) {
        LKAlarmEvent * event = [events objectAtIndex:i];
        NSString *key = [[self dateFormatter] stringFromDate:event.startDate];
        if (!eventsByDate[key]) {
            eventsByDate[key] = [NSMutableDictionary new];
        }
        NSString * eventId = [NSString stringWithFormat: @"%ld", (long)event.eventId];
        eventsByDate[key][eventId] = event;
        NSLog(@"Event: %@ ,Date: %@ ",event.title, key);
        
    }
    NSLog(@"events count %lu",(unsigned long)events.count);
}
- (NSArray *)getEventsOneDay:(NSDate *)date{
    NSArray *events;
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    events = [[NSArray alloc]initWithArray:[(NSMutableDictionary*)eventsByDate[key] allValues]];
    for (LKAlarmEvent *event in events) {
        NSLog(@"Event:%@ - Date:%@",event.title ,key);
    }
    
    return events;
}

#pragma mark  Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 180;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 60.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         self.backViewHeight.constant = newHeight + 44;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}

#pragma mark  Fake data

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScheduleCell * cell = [tableView dequeueReusableCellWithIdentifier:JFScheduleCell forIndexPath:indexPath];
    [cell setEvent:tableViewDateSource[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableViewDateSource.count;
}
-(void)reminderCellTouchAction:(id)sender{
    NSLog(@"reminderImage Touch Action");
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ScheduleCell cellHeight:tableViewDateSource[indexPath.row]];
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark - View
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tableView reloadData];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}


#pragma mark - 页面跳转
- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}

#pragma mark - 为整个App设置一个字体,但不指定字体大小的方法 （不用了）
-(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
    }
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES];
        }
    }
}

@end
