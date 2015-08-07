//
//  CalenderStyleViewController.m
//  Step-it-up
//
//  Created by syfll on 15/7/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#define JF_Calender_ContentView_Height 180

#import "Todo_CalenderViewController.h"
#import "ScheduleFootCell.h"
#import "ScheduleHeadCell.h"
#import "ScheduleCell.h"
#import "LKAlarmMamager.h"
#import "JTCalendar.h"

@interface Todo_CalenderViewController ()<JTCalendarDataSource,UITableViewDataSource, UITableViewDelegate>
{
    NSMutableDictionary *eventsByDate;
    NSArray * tableViewDateSource;
}

@property (strong, nonatomic) NSMutableDictionary *offscreenCells;

//日程列表相关
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ScheduleFootCell *tableFootView;
@property (strong, nonatomic) ScheduleHeadCell *tableHeadView;

//日历相关
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTCalendarContentView *calendarContentView;
@property (strong, nonatomic) UIButton *changeDateBtn;

//
@property (strong, nonatomic) JTCalendar *calendar;

@end

@implementation Todo_CalenderViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    self.offscreenCells = [NSMutableDictionary dictionary];
    
    
    self.calendar = [JTCalendar new];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    self.tableFootView = [[ScheduleFootCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JFScheduleFootCell];
    self.tableHeadView = [[ScheduleHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JFScheduleHeadCell];
    
    self.changeDateBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    self.calendarContentView = [[JTCalendarContentView alloc]initWithFrame:CGRectZero];
    self.calendarMenuView  = [[JTCalendarMenuView alloc]initWithFrame:CGRectZero];
    self.backView = [[UIView alloc]initWithFrame:CGRectZero];
    
    //日程列表
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:[ScheduleCell class] forCellReuseIdentifier:JFScheduleCell];
    
    
    
    //添加日历阴影
    CALayer * calendarLayer = self.backView.layer;
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
    
    
    //changeDateBtn
    
    
    [self.changeDateBtn setImage:[UIImage imageNamed:@"multiply_down"] forState:UIControlStateNormal];
    [self.changeDateBtn setImage:[UIImage imageNamed:@"multiply_up"] forState:UIControlStateSelected];

    [self.changeDateBtn addTarget:self action:@selector(didChangeModeTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    //日历
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
    self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
    self.calendar.calendarAppearance.ratioContentMenu = 1.;
    self.calendarMenuView.backgroundColor =[UIColor clearColor];
    self.calendarContentView.backgroundColor = [UIColor clearColor];
    
    self.backView.backgroundColor = [[UIColor alloc]initWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    
    //更新按钮图片
//    if (self.calendar.calendarAppearance.isWeekMode == true) {
//        [self.changeDateBtn setImage:[UIImage imageNamed:@"multiply_down"] forState:UIControlStateNormal];
//    }else{
//        [self.changeDateBtn setImage:[UIImage imageNamed:@"multiply_up"] forState:UIControlStateNormal];
//    }
    [self didChangeModeTouch:nil];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.calendarMenuView];
    [self.backView addSubview:self.calendarContentView];
    [self.view addSubview:self.changeDateBtn];
    
    [self createConstraints];

    tableViewDateSource = [self getEventsOneDay:self.calendar.currentDate];
    

    
}
//初始化限制
-(void)createConstraints{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.calendarContentView.mas_bottom);
    }];
    [self.calendarMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    [self.calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarMenuView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(@JF_Calender_ContentView_Height);
    }];
    [self.changeDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.calendarContentView.mas_centerX);
        make.top.equalTo(self.calendarContentView.mas_bottom);
        make.height.equalTo(@22);
        make.width.equalTo(@58);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarContentView.mas_bottom);
        make.left.right.and.bottom.equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - View
-(void)showTableHeadAndFootView:(BOOL)isShow{
    if (isShow) {
        self.tableView.tableHeaderView = self.tableHeadView;
        self.tableView.tableFooterView = self.tableFootView;
    }else{
        self.tableView.tableHeaderView = nil;
        self.tableView.tableFooterView = nil;
    }
    
}
#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScheduleCell * cell = [tableView dequeueReusableCellWithIdentifier:JFScheduleCell forIndexPath:indexPath];
    //[tableView dequeueReusableCellWithIdentifier:JFScheduleCell];
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
    {
        cell.contentView.frame = cell.bounds;
        cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    }
    [cell setEvent:tableViewDateSource[indexPath.row]];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
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
    NSString *reuseIdentifier = JFScheduleCell;
    
    ScheduleCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
    if (!cell) {
        //cell = [[ScheduleCell alloc] init];
        cell = [[ScheduleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        [self.offscreenCells setObject:cell forKey:reuseIdentifier];
    }
    //设置cell内容
    [cell setEvent:tableViewDateSource[indexPath.row]];
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    // NOTE: if you are displaying a section index (e.g. alphabet along the right side of the table view), or
    // if you are using a grouped table view style where cells have insets to the edges of the table view,
    // you'll need to adjust the cell.bounds.size.width to be smaller than the full width of the table view we just
    // set it to above. See http://stackoverflow.com/questions/3647242 for discussion on the section index width.
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    return height;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
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
    
    tableViewDateSource = [self getEventsOneDay:date];
    
//    [UIView transitionWithView:self.tableView duration:.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
//        [self.tableView reloadData];
//    } completion:nil];
    [self.tableView reloadData];
    //点击日期后改变显示模式
    [self.calendar setCurrentDate: date];
    
    if (!self.calendar.calendarAppearance.isWeekMode) {
        self.calendar.calendarAppearance.isWeekMode = true;
        [self transitionExample];
    }
    
}
#pragma mark 更新数据
- (void)updateEvents{
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
//  根据时间获取日程
//  获取日程前请先调用[self updateEvents]更新数据
- (NSArray *)getEventsOneDay:(NSDate *)date{
    [self updateEvents];
    NSArray *events;
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    events = [[NSArray alloc]initWithArray:[(NSMutableDictionary*)eventsByDate[key] allValues]];
    for (LKAlarmEvent *event in events) {
        NSLog(@"Event:%@ - Date:%@",event.title ,key);
    }
    
    if (!events || events.count == 0) {
        [self showTableHeadAndFootView:false];
    }else{
        [self showTableHeadAndFootView:true];
    }
    //[self.tableView reloadData];
    return events;
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}
#pragma mark  Transition examples

- (void)transitionExample
{
    CGFloat newHeight = JF_Calender_ContentView_Height;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 60.;
    }
    
    [self.calendarContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(newHeight));
        
    }];
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(newHeight + 44));
    }];

    [UIView animateWithDuration:.5
                     animations:^{
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

@end

