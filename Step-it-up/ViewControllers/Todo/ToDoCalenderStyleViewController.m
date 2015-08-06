//
//  HomeViewController.m
//  changer
//
//  Created by syfll on 14-12-2.
//  Copyright (c) 2014年 syfll. All rights reserved.
//  参考https://github.com/smileyborg/TableViewCellWithAutoLayout
//

#import "ToDoCalenderStyleViewController.h"
#import "SIUMacros.h"
#import "XHPopMenu.h"
#import "LKAlarmMamager.h"
#import "ScheduleCell.h"
#import "ScheduleFootCell.h"
#import "ScheduleHeadCell.h"

#define kDefaultAnimationDuration 0.25f
#define FontSize 23.0f

@interface ToDoCalenderStyleViewController (){
    NSMutableDictionary *eventsByDate;
    NSArray * tableViewDateSource;

}

// A dictionary of offscreen cells that are used within the tableView:heightForRowAtIndexPath: method to
// handle the height calculations. These are never drawn onscreen. The dictionary is in the format:
//      { NSString *reuseIdentifier : UITableViewCell *offscreenCell, ... }
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;
@property (weak, nonatomic) IBOutlet UITableView *scheduleTableView;

@property (strong, nonatomic) ScheduleFootCell *tableFootView;
@property (strong, nonatomic) ScheduleHeadCell *tableHeadView;

@end

@implementation ToDoCalenderStyleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.offscreenCells = [NSMutableDictionary dictionary];
    
    _tableFootView = [[ScheduleFootCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JFScheduleFootCell];
    _tableHeadView = [[ScheduleHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JFScheduleHeadCell];
    
    _scheduleTableView.backgroundView = [[UIView alloc]init];
    [_scheduleTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    _scheduleTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    _scheduleTableView.allowsSelection = NO;
    
    [_scheduleTableView registerClass:[ScheduleCell class] forCellReuseIdentifier:JFScheduleCell];
    
    _scheduleTableView.dataSource = self;
    _scheduleTableView.delegate = self;
    //更新一下日程
    [self updateEvents];
    
    
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
    //日历
    self.calendar = [JTCalendar new];
    
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
    
    [self updateEvents];
    tableViewDateSource = [self getEventsOneDay:date];
    [self.scheduleTableView reloadData];
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
    
    ScheduleCell * cell = [tableView dequeueReusableCellWithIdentifier:JFScheduleCell];
    
    [cell setEvent:tableViewDateSource[indexPath.row]];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
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
        cell = [[ScheduleCell alloc] init];
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
    height += 20;
    
    return height;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark - View
-(void)showTableHeadAndFootView:(BOOL)isShow{
    if (isShow) {
        self.scheduleTableView.tableHeaderView = self.tableHeadView;
        self.scheduleTableView.tableFooterView = self.tableFootView;
    }else{
        self.scheduleTableView.tableHeaderView = nil;
        self.scheduleTableView.tableFooterView = nil;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.scheduleTableView reloadData];
    
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
